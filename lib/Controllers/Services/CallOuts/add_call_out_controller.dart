import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Pages/Profile/Widgets/get_fields_for_profile.dart';
import 'package:paakaar/Pages/RequestService/Widgets/ChooseCallOutSourceAlert.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_option_values_widget.dart';
import 'package:paakaar/Plugins/datePicker/persian_datetime_picker.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paakaar/Widgets/get_fields_and_groups_dialog.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Modals/call_out_image_picker_modal.dart';

class AddCallOutController extends GetxController {
  List<OptionModel> listOfOptions = [];
  List<FieldModel> listOfFields = [];
  List<FieldModel> listOfGroups = [];
  late FieldModel field;
  RxBool isFieldsLoaded = false.obs;
  final ProjectRequestUtils requests = ProjectRequestUtils();
  final PageController pageController = PageController();
  final FRefreshController refreshController = FRefreshController();

  RxBool isOptionsLoaded = false.obs;

  XFile? fileImage;
  RxBool isStatesLoaded = false.obs;

  late List<StateModel> listOfStates;

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();
  final TextEditingController districtTextController = TextEditingController();

  final TextEditingController phoneTextController = TextEditingController();

  final TextEditingController linkTextController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int dayId = 0;

  String selectedDay = Jalali.now().jDate();

  @override
  void onInit() {
    initUniLinks();
    getFields().then((value) {
      getDataDialog();
    });
    getStates();
    super.onInit();
  }

  Future<void> getFields() async {
    isFieldsLoaded.value = false;
    listOfFields.clear();

    ApiResult result = await requests.getAllFields();
    if (result.isDone) {
      listOfFields = FieldModel.listFromJson(
        result.data,
      );
      listOfFields.first.isSelected.value = true;
      isFieldsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getPublicOptions() async {
    isOptionsLoaded.value = false;

    ApiResult result = await ProjectRequestUtils.instance.getPublicOptions(
      field.id,
    );

    if (result.isDone) {
      listOfOptions = OptionModel.listFromJson(
        result.data,
      );
      isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getOptions() async {
    print('get options');
    isOptionsLoaded.value = false;

    List<int> ids = [listOfGroups.last.id];

    ApiResult result = await ProjectRequestUtils.instance.getOptionsByListOfIds(
      ids,
    );

    if (result.isDone) {
      listOfOptions.addAll(
        OptionModel.listFromJson(
          result.data,
          isPublic: false,
        ),
      );
      isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void makeCityActive(item) {
    listOfStates
        .singleWhere((element) => element.isSelected)
        .listOfCities
        .forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;
    refresh();
  }

  void makeStateActive(item) {
    for (var element in listOfStates) {
      element.isSelected = false;
    }
    item.isSelected = true;
    update();
    isStatesLoaded.toggle();
    isStatesLoaded.toggle();
  }

  void showModalBottomSheet() {
    showMaterialModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ShowEditImageCallOutModal(
        controller: this,
      ),
    );
  }

  void showSourceAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ChooseCallOutSourceAlert(controller: this),
      ),
      barrierColor: ColorUtils.black.withOpacity(0.5),
    );
  }

  void getOptionValues(OptionModel option) {
    Get.bottomSheet(
      GetOptionValuesWidget(
        expertListController: this,
        option: option,
      ),
    );
  }

  ImageCropper? cropper = ImageCropper();

  void setPicture({XFile? image}) async {

    File? croppedFile = await cropper!.cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio16x9,
      ],
      aspectRatio: const CropAspectRatio(
        ratioX: 16,
        ratioY: 9,
      ),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'تنظیمات ابعاد عکس',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (croppedFile is File) {
      fileImage = XFile(
        croppedFile.path,
      );
      // Get.back();
      Get.back();
    }
    update();
  }

  void deleteImage() {
    fileImage = null;
    Get.back();
    update();
  }

  void saveCallOut() async {
    String canContinue = await validate();
    if (canContinue == 'done') {
      if ((pageController.page?.toInt() ?? 0) < 2) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 125),
          curve: Curves.easeIn,
        );
        Future.delayed(const Duration(milliseconds: 250), () {
          refresh();
        });
        return;
      }
    } else {
      ViewUtils.showErrorDialog(canContinue);
      return;
    }
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.saveCallOut(
      fieldId: field.id,
      categoryId: listOfGroups[listOfGroups.length - 2].id,
      specialityId: listOfGroups.last.id,
      listOptions: listOfOptions
          .where((element) => element.isSelected)
          .map(
            (e) => {
              'id': e.id,
              'valueId': e.values
                  .singleWhere((element) => element.isSelected.isTrue)
                  .id,
              'isPublic': e.isPublic,
            },
          )
          .toList(),
      text: descTextController.text,
      image: (fileImage == null) ? '' : fileImage,
      phoneNumber: phoneTextController.text,
      link: linkTextController.text,
      day: dayId == 3 ? selectedDay : dayId.toString(),
      district: districtTextController.text,
      stateId: listOfStates.singleWhere((element) => element.isSelected).id,
      cityId: listOfStates
          .singleWhere((element) => element.isSelected)
          .listOfCities
          .singleWhere((element) => element.isSelected)
          .id,
      title: titleTextController.text,
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data['type'] == 'free') {
        Get.back();
        Get.back();
        // Get.back();
        Globals.userStream.addCallOut();
        ViewUtils.showSuccessDialog(
          result.data['message'].toString(),
        );
      } else {
        if (result.data['status'] == true) {
          initUniLinks();
          launch(
            result.data['url'],
          );
        } else {
          ViewUtils.showErrorDialog(
            result.data['message'].toString(),
          );
        }
      }
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      // Use the uri and warn the user, if it is not correct

      Map<String, dynamic> myMap = jsonDecode(uri!.queryParameters['data']!);
      print(myMap);


      if (myMap['status']) {
        Get.back();
        Get.back();
        Get.back();
        Globals.userStream.addCallOut();
        Get.offAndToNamed(RoutingUtils.dashboard.name , );
        ViewUtils.showSuccessDialog(
          'پرداخت شما با موفقیت انجام شد!',
        );
      } else {
        ViewUtils.showErrorDialog('پرداخت نا موفق ، فراخوان ثبت نشد');
      }
      // AlertHelper.paymentStatus(
      //     success: uri!.queryParameters['status'] == 'true',
      //     failedFunc: (){
      //       Get.back();
      //       // Future.delayed(Duration(milliseconds: 200) , (){
      //       //   adsController.clearAllData();
      //       //   adsController.onClose();
      //       // });
      //     },
      //     successFunc: (){
      //       submitTap();
      //     }
      // );
      // print(uri!.queryParameters['data']);
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  void showLottie(bool success) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SizedBox.expand(
          child: Container(
            margin: const EdgeInsets.all(50.0),
            child: Center(
              child: success ? ImageUtils.creditSuccess : ImageUtils.creditFail,
            ),
          ),
        );
      },
    );
  }

  Future<String> validate() async {
    switch (pageController.page?.toInt()) {
      case 1:
        if (titleTextController.text.isEmpty) {
          return "لطفا عنوان را وارد کنید";
        }
        break;
      case 2:
        if (!listOfStates.any((element) => element.isSelected)) {
          return "لطفا استان را انتخاب کنید";
        }
        if (!listOfStates
            .singleWhere((element) => element.isSelected)
            .listOfCities
            .any((city) => city.isSelected)) {
          return "لطفا شهر را انتخاب کنید";
        }
        if (descTextController.text.isEmpty) {
          return "لطفا توضیحات را وارد کنید";
        }
        break;
    }
    return 'done';
  }

  void goBack() {
    if (listOfLists.isNotEmpty) {
      listOfLists.removeLast();
      listOfGroups.removeLast();
      isLoading.value = true;
      Get.back();
      Get.back();
      update();
    } else {
      // Get.close(1);
      // listOfLists.removeLast();
      // listOfGroups.removeLast();
      // isLoading.value = true;
      // isLoading.value = false;
      Get.back();
      Get.back();
    }
  }

  void getDataDialog() async {
    FieldModel? field = await Get.dialog(
      GetFieldsForProfile(
        list: listOfFields,
        fromCalls: true,
        title: "زمینه کاری مورد نظر را انتخاب کنید",
        isFirst: true,
        isDirect: true,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
    );
    if (field is FieldModel) {
      this.field = field;
      getSubGroups();
    }
  }

  RxBool isLoading = true.obs;
  List<List<FieldModel>> listOfLists = [];

  Future<void> getNextLevel({
    bool refresh = false,
  }) async {
    ApiResult? result;

    isLoading.value = true;
    switch (listOfGroups.length) {
      case 0:
        result = await requests.getMainCategories(
          field.id,
        );
        break;
      default:
        if (listOfGroups.last.hasSubCategory) {
          result = await requests.getSubCategories(
            listOfGroups.last.id,
          );
        } else if (!listOfGroups.last.isSpeciality) {
          result = await requests.getSpecialities(
            listOfGroups.last.id,
          );
          // Get.toNamed(RoutingUtils.requestService.name, arguments: {
          //   'field': field,
          //   'type': 1,
          // });
        } else {
          isLoading.value = false;
          // tmpList = listOfGroups;

          // Get.toNamed(
          //   RoutingUtils.requestService.name,
          //   arguments: {
          //     'field': field,
          //     'type': Get.arguments['type'],
          //     'list':tmpList,
          //     'last':tmpList.last
          //   },
          // );
          // listOfGroups.removeLast();
          Get.back();
          update();
          // listOfLists.removeLast();
          return;
        }
    }

    if (result.isDone == true) {
      if (refresh) {
        listOfLists.removeLast();
      }
      listOfLists.add(
        FieldModel.listFromJson(result.data),
      );
      update();
      isLoading.value = false;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getStates() async {
    ApiResult result = await requests.allStatesAndCities();
    if (result.isDone) {
      listOfStates = StateModel.listFromJson(
        result.data,
      );
      // listOfStates.insert(
      //   0,
      //   StateModel(
      //     name: 'همه استان ها',
      //     id: 0,
      //     listOfCities: [],
      //   ),
      // );
      isStatesLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getSubGroups({
    int delay = 200,
  }) {
    Future.delayed(
      Duration(milliseconds: delay),
      () async {
        await getNextLevel();
        await Get.dialog(
          GetFieldsAndGroupsDialog(
            field: field,
            controller: this,
          ),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
        );
        print(listOfGroups);
        getOptions();
      },
    );
  }
}
