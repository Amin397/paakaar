import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paakaar/Controllers/Services/Modals/call_out_image_picker_modal.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Pages/RequestService/Widgets/ChooseCallOutSourceAlert.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class AdAddController extends GetxController {
  late List<FieldModel> listOfFields;

  RxBool isFieldsLoaded = false.obs;
  RxBool isStatesLoaded = false.obs;
  final ProjectRequestUtils requests = ProjectRequestUtils();

  final TextEditingController linkTextController = TextEditingController();
  late List<StateModel> listOfStates;

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();
  final TextEditingController priceTextController = TextEditingController();
  XFile? fileImage;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isFieldSelected = false;
  bool isStateSelected = false;
  bool isCitySelected = false;

  @override
  void onInit() {
    initUniLinks();
    getFields();
    getStates();
    super.onInit();
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      // Use the uri and warn the user, if it is not correct

      Map<String, dynamic> myMap = jsonDecode(uri!.queryParameters['data']!);
      print(myMap['status'].runtimeType);
      if (myMap['status']) {
        ViewUtils.showSuccessDialog(
          'پرداخت شما با موفقیت انجام شد!',
        );
        Get.offAndToNamed(RoutingUtils.dashboard.name);
      } else {
        ViewUtils.showErrorDialog('پرداخت نا موفق ، آگهی ثبت نشد');
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

  void getFields() async {
    ApiResult result = await requests.getAllFields();
    if (result.isDone) {
      listOfFields = FieldModel.listFromJson(
        result.data,
      );
      isFieldsLoaded.value = true;
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
      listOfStates.insert(
        0,
        StateModel(
          id: 0,
          name: "همه ی استان ها",
          listOfCities: [],
        ),
      );
      isStatesLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void makeFieldActive(item) {
    listOfFields.forEach((element) {
      element.isSelected.value = false;
    });
    item.isSelected.value = true;
    refresh();
    isFieldsLoaded.toggle();

    unFocus();
    isFieldSelected = true;
    isFieldsLoaded.toggle();
  }

  void makeCityActive(item) {
    listOfStates
        .singleWhere((element) => element.isSelected)
        .listOfCities
        .forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;
    unFocus();
    isCitySelected = true;
    refresh();
  }

  void makeStateActive(item) {
    listOfStates.forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;
    refresh();
    unFocus();
    isStatesLoaded.toggle();
    isStateSelected = true;
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

  void setPicture({XFile? image}) async {
    File? croppedFile = await ImageCropper.cropImage(
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
      Get.back();
    }
    update();
  }

  void deleteImage() {
    fileImage = null;
    Get.back();
    update();
  }

  void showSourceAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ChooseCallOutSourceAlert(
          controller: this,
        ),
      ),
      barrierColor: ColorUtils.black.withOpacity(0.5),
    );
  }

  void saveAd() async {
    if (isFieldSelected) {
      EasyLoading.show();
      ApiResult result = await requests.saveAd(
        fieldId:
            listOfFields.singleWhere((element) => element.isSelected.value).id,
        price: priceTextController.text.replaceAll(',', ''),
        stateId:(listOfStates.any((element) => element.isSelected))? listOfStates.singleWhere((element) => element.isSelected).id:0,
        cityId:(listOfStates.any((element) => element.isSelected && element.id != 0))? listOfStates
            .singleWhere((element) => element.isSelected)
            .listOfCities
            .singleWhere((element) => element.isSelected)
            .id:0,
        title: titleTextController.text,
        link: linkTextController.text,
        cover: (fileImage == null) ? '' : fileImage!,
        desc: descTextController.text,
      );
      EasyLoading.dismiss();
      if (result.isDone) {
        print(result.data);
        if (result.data['url'] is String) {
          initUniLinks();
          launch(result.data['url']);
        } else {
          Get.back();
          ViewUtils.showSuccessDialog(
            'آگهی شما با موفقیت ثبت شد',
          );
          Globals.userStream.addAds();
        }
      } else {
        ViewUtils.showErrorDialog(
          result.data,
        );
      }
    } else {
      ViewUtils.showErrorDialog(
        'ابتدا باید زمینه های کاری را انتخاب کنید',
      );
    }
  }
}
