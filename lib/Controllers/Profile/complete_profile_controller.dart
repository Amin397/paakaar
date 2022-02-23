import 'dart:convert';
import 'dart:io' as io;
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paakaar/Controllers/Profile/Widgets/cv_item_data_dialog.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/social_media_model.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/Locations/DistrictModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Pages/Profile/Widgets/choose_source_alert.dart';
import 'package:paakaar/Pages/Profile/Widgets/get_last_fields_with_sub_groups.dart';
import 'package:paakaar/Pages/Profile/Widgets/set_address_for_social_media.dart';
import 'package:paakaar/Pages/Profile/Widgets/show_edit_image_modal.dart';
import 'package:paakaar/Pages/Profile/Widgets/get_fields_for_profile.dart';
import 'package:paakaar/Pages/Profile/Widgets/max_specialities_exceeded.dart';
import 'package:paakaar/Pages/Profile/Widgets/new_field_dialog.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_filters_dialog.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_option_values_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

import 'Widgets/save_alert_widget.dart';

class CompleteProfileController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();
  List<FieldModel> listOfSubSubGroups =
      Globals.userStream.user?.specialities ?? [];
  List<CustomFileModel> listOfCvFiles = [];
  List<FieldModel> listOfFields = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController searchController = TextEditingController();
  late List<ProfileStateModel> listOfStates;
  List<DistrictModel> listOfDistricts = [];
  RxBool isStatesLoaded = false.obs;

  bool isDeleting = false;

  late List<SocialMediaModel> listOfSocialMedias;
  RxBool isSocialMediaLoaded = false.obs;
  FieldModel? selectedField = (Globals.userStream.user?.fields?.length ?? 0) > 0
      ? Globals.userStream.user?.fields?.first
      : null;
  final TextEditingController addressTextController = TextEditingController();

  final TextEditingController bioTextController = TextEditingController();
  final TextEditingController cvTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameController = TextEditingController(
    text: Globals.userStream.user!.firstName!,
  );

  final TextEditingController lastNameController = TextEditingController(
    text: Globals.userStream.user!.lastName!,
  );

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  int gender = Globals.userStream.user!.gender!;

  bool showMobile = Globals.userStream.user?.isMobileShown ?? false;

  List<FieldModel> listOfGroups = [];

  void selectGender(int i) {
    gender = i;
    refresh();
    unFocus();
  }

  void getStates() async {
    ApiResult result = await ProjectRequestUtils.instance.allStatesAndCities();
    if (result.isDone) {
      listOfStates = ProfileStateModel.listFromJson(
        result.data,
      );
      // listOfStates.insert(
      //   0,
      //   ProfileStateModel(
      //     id: 0,
      //     listOfCities: [],
      //     name: 'همه ی استان ها',
      //   ),
      // );
      if (Globals.userStream.user?.state is ProfileStateModel) {
        listOfStates
            .singleWhere(
              (element) => element.id == Globals.userStream.user?.state?.id,
            )
            .isSelected = true;
      }
      if (Globals.userStream.user?.city is CityModel) {
        listOfStates
            .singleWhere(
              (element) => element.id == Globals.userStream.user?.state?.id,
            )
            .isSelected = true;
        listOfStates
            .singleWhere(
              (element) => element.isSelected,
            )
            .listOfCities
            .singleWhere(
              (element) => element.id == Globals.userStream.user?.city?.id,
            )
            .isSelected = true;
      }
      isStatesLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  Future<bool> getFields() async {
    ApiResult result = await requests.getAllFields();
    if (result.isDone) {
      listOfFields = FieldModel.listFromJson(
        result.data,
      );
      if ((Globals.userStream.user?.fields?.length ?? 0) > 0) {
        listOfFields
            .singleWhere((element) =>
                element.id == Globals.userStream.user?.fields?.first.id)
            .isSelected
            .value = true;
      }
      return true;
    } else {
      return false;
    }
  }

  void getSocialMedias() async {
    ApiResult result = await requests.allSocialMediaAddresses();
    if (result.isDone) {
      listOfSocialMedias = SocialMediaModel.listFromJson(
        result.data,
      );
      isSocialMediaLoaded.value = true;
      update();
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void selectFieldsAndGroups() async {
    unFocus();
    if (listOfSubSubGroups.length >= 2) {
      bool? result = await Get.dialog(
        const MaxSpecialitiesExceeded(),
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: false,
      );
      if (result == true) {
        if (listOfSubSubGroups.length >= 2) {
          listOfSubSubGroups.clear();
          listOfFields.forEach((element) {
            element.isSelected.value = false;
          });
          update();
        }
      }
      if (result == false) {
        return;
      }
    }

    FieldModel? field = await Get.dialog(
      GetFieldsForProfile(
        list: listOfFields,
        fromCalls: false,
        title: "زمینه کاری خود را انتخاب کنید",
        isFirst: true,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
    );
    if (field is FieldModel) {
      if (selectedField?.id != field.id) {
        bool? result = await Get.dialog(
          NewFieldDialog(),
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: false,
        );
        if (result == true) {
          listOfSubSubGroups.clear();
        } else {
          return;
        }
      }
      selectedField = field;
      EasyLoading.show();

      ApiResult mainGroupsResult = await requests.getMainCategories(
        field.id,
      );

      EasyLoading.dismiss();
      if (mainGroupsResult.isDone) {
        FieldModel? mainGroup = await Get.dialog(
          GetFieldsForProfile(
            isFirst: false,
            fromCalls: false,
            list: FieldModel.listFromJson(mainGroupsResult.data),
            title: "گروه اصلی تخصصص های خود را انتخاب کنید",
          ),
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: false,
        );
        if (mainGroup != null) {
          listOfGroups.clear();
          bool addAll = listOfSubSubGroups.length <= 1;
          var lastField = await getLastField(mainGroup);
          if (lastField is List<FieldModel>) {
            // if (addAll) {
            //   listOfSubSubGroups.removeLast();
            //   listOfSubSubGroups.add(lastField[lastField.length - 1]);
            // } else {
            listOfSubSubGroups = lastField;
            // }
            getOptions(
              listOfSubSubGroups.map((e) => e.id).toList(),
            );
            update();
          }
        }
      }
    }
  }

  @override
  void onInit() {
    getSocialMedias();
    getStates();
    getFields();
    getOptions(
      Globals.userStream.user?.specialities?.map((e) => e.id).toList() ?? [],
      isInit: true,
    );
    getCvFiles();
    bioTextController.text = Globals.userStream.user!.bio ?? '';
    cvTextController.text = Globals.userStream.user!.individualCv ?? '';
    if (Globals.userStream.user!.region is DistrictModel) {
      getDistricts(Globals.userStream.user!.city!.id, true);
      // listOfDistricts.add(Globals.userStream.user!.region!);

    }
    super.onInit();
  }

  void makeCityActive(item) {
    listOfStates
        .singleWhere((element) => element.isSelected)
        .listOfCities
        .forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;

    getDistricts(item.id, false);
    unFocus();
    update();
  }

  void makeStateActive(item) {
    for (var element in listOfStates) {
      element.isSelected = false;
    }
    listOfDistricts = [];
    // listOfStates
    //     .singleWhere((element) => element.isSelected)
    //     .listOfCities
    //     .forEach((element) {
    //   element.isSelected = false;
    // });
    // item.isSelected = !item.isSelected;
    item.isSelected = !item.isSelected;
    item.listOfCities.map((e) => e.isSelected = false).toList();
    unFocus();
    update();
    isStatesLoaded.toggle();
    isStatesLoaded.toggle();
  }

  void makeDistrictActive(item) {
    for (var element in listOfDistricts) {
      element.isSelected = false;
    }
    item.isSelected = !item.isSelected;
    item.isSelected = true;
    if (item.id == 0) {
      listOfDistricts = [];
    }
    unFocus();
    update();
  }

  void addCvFile() async {
    unFocus();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      io.File file = io.File(result.files.single.path!);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      // if (sizeInMb > (Globals.userStream.user?.maxCvFileSize ?? 10)) {
      if (sizeInMb > 25) {
        ViewUtils.showErrorDialog(
          "حجم فایل انتخاب شده بیشتر از حد مجاز است",
        );
        return;
      }
      CustomFileModel cvItem = CustomFileModel(
        file: file,
      );
      await Get.dialog(
        CvItemDataDialog(
          file: cvItem,
          controller: this,
        ),
        barrierDismissible: false,
      );
    } else {
      // User canceled the picker
    }
  }

  uploadFile({CustomFileModel? file}) async {
    EasyLoading.show(status: 'درحال بارگذاری اطلاعات لطفا صبر کنید');
    ApiResult result = await requests.uploadFile(file: file);
    EasyLoading.dismiss();
    if (result.isDone) {
      ViewUtils.showSuccessDialog(
        "بارگذاری فایل با موفقیت انجام شد",
      );
      listOfCvFiles.add(
        file!,
      );
      update();
    } else {
      ViewUtils.showErrorDialog(
        'بارگذاری فایل با خطا مواجه شد',
      );
    }
  }

  void save({bool? fromAppBar}) async {
    List<int> listOfSubSubGroups =
        this.listOfSubSubGroups.map((e) => e.id).toList();
    EasyLoading.show();
    Map<String, String> listOfSocialMedia = {};
    for (var element in listOfSocialMedias) {
      if (element.isAddressSet) {
        listOfSocialMedia[element.id.toString()] = element.address!;
      }
    }
    ApiResult result = await requests.saveProfile(
      listOfSubSubGroups: listOfSubSubGroups,
      listOfSocialMedia: listOfSocialMedia,
      region: listOfDistricts.any((element) => element.isSelected)
          ? listOfDistricts.singleWhere((element) => element.isSelected).id
          : 0,
      cvFiles: listOfCvFiles,
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
      image: Globals.userStream.user!.avatarFile,
      bio: bioTextController.text,
      fName: nameController.text,
      lName: lastNameController.text,
      cv: cvTextController.text,
      password: passwordTextController.text,
      showMobile: showMobile,
      stateId: listOfStates.any((element) => element.isSelected)
          ? listOfStates.singleWhere((element) => element.isSelected).id
          : 0,
      cityId: listOfStates.any((element) => element.isSelected) &&
              listOfStates
                  .singleWhere((element) => element.isSelected)
                  .listOfCities
                  .any((element) => element.isSelected)
          ? listOfStates
              .singleWhere((element) => element.isSelected)
              .listOfCities
              .singleWhere((element) => element.isSelected)
              .id
          : 0,
    );
    EasyLoading.dismiss();

    if (result.isDone) {
      UserModel userModel = UserModel.fromJson(
        result.data,
      );
      Globals.userStream.changeUser(userModel);
      if (fromAppBar == true) {
        Get.back();
        Get.back();
      }
      // Future.delayed(Duration(seconds: 5),(){
      //   getUserData(
      //     fromAppBar: fromAppBar,
      //   );
      // });
      ViewUtils.showSuccessDialog(
        'تغییرات با موفقیت اعمال شد',
      );
    } else {
      EasyLoading.dismiss();
      ViewUtils.showSuccessDialog(
        result.data.toString(),
      );
    }
  }

  getUserData({bool? fromAppBar}) async {
    ApiResult result = await requests
        .getIndividualData(Globals.userStream.user!.id.toString());
    EasyLoading.dismiss();
    if (result.isDone) {
      Globals.userStream.user = UserModel.fromJson(
        result.data,
      );
      Globals.userStream.sync();
      ViewUtils.showSuccessDialog(
        "تغییرات با موفقیت اعمال شد",
      );
      if (fromAppBar is bool) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      }
    }
  }

  void showModalBottomSheet() {
    showMaterialModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ShowEditImageModal(
        controller: this,
      ),
    );
  }

  void showSourceAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ChooseSourceAlert(),
      ),
      barrierColor: ColorUtils.black.withOpacity(0.5),
    );
  }

  void setAddressForSocialMedia(SocialMediaModel socialMedia) {
    addressTextController.text =
        socialMedia.address is String ? socialMedia.address! : '';
    Get.dialog(
      SetAddressForSocialMedia(
        controller: this,
        socialMedia: socialMedia,
      ),
      barrierColor: ColorUtils.black.withOpacity(0.5),
    );
  }

  void saveSocialMediaAddress(
    String text,
    SocialMediaModel socialMediaModel,
  ) {
    listOfSocialMedias.forEach((element) {
      if (element.id == socialMediaModel.id) {
        if (text == '') {
          element.address = null;
        } else {
          element.address = text;
        }
      }
    });
    update();
    Get.close(1);
  }

  void selectPublicFilters() {
    unFocus();
    Get.dialog(
      GetFiltersDialog(
        controller: this,
      ),
    );
  }

  RxBool isOptionsLoaded = false.obs;
  List<OptionModel> listOfOptions = [];

  void getOptions(
    List<int> ids, {
    bool isInit = false,
  }) async {
    isOptionsLoaded.value = false;
    ApiResult result = await ProjectRequestUtils.instance.getOptionsByListOfIds(
      ids,
    );
    if (result.isDone) {
      listOfOptions.clear();
      listOfOptions.addAll(
        OptionModel.listFromJson(
          result.data,
          isPublic: false,
        ),
      );
      if (isInit) {
        listOfOptions.where((element) => element.isPublic).forEach((element) {
          if (Globals.userStream.user?.listOfPublicFilters
                  ?.any((e) => e.id == element.id) ==
              true) {
            element.values
                .singleWhere(
                  (el) {
                    return Globals.userStream.user?.listOfPublicFilters
                            ?.where((e3) {
                              return e3.isSelected;
                            })
                            .toList()
                            .any((e4) {
                              return e4.values
                                  .where((element) => element.isSelected.isTrue)
                                  .map((e5) => e5.id)
                                  .contains(el.id);
                            }) ??
                        false;
                  },
                )
                .isSelected
                .value = true;
          }
        });
        listOfOptions.where((element) => !element.isPublic).forEach((element) {
          if (Globals.userStream.user?.listOfOptions
                  ?.any((e) => e.id == element.id) ==
              true) {
            element.values
                .singleWhere(
                  (el) {
                    return Globals.userStream.user?.listOfOptions
                            ?.where((e3) {
                              return e3.isSelected;
                            })
                            .toList()
                            .any((e4) {
                              return e4.values
                                  .where((element) => element.isSelected.isTrue)
                                  .map((e5) => e5.id)
                                  .contains(el.id);
                            }) ??
                        false;
                  },
                )
                .isSelected
                .value = true;
          }
        });
      }
      update();
      isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getOptionValues(OptionModel option) {
    Get.bottomSheet(
      GetOptionValuesWidget(
        expertListController: this,
        option: option,
      ),
    );
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  void getCvFiles() {
    Globals.userStream.user?.cvItems?.forEach((element) {
      listOfCvFiles.add(
        element,
      );
    });
  }

  Future<dynamic> getLastField(FieldModel? mainGroup) async {
    if (mainGroup != null) {
      listOfGroups.add(mainGroup);
      if (mainGroup.hasSubCategory) {
        EasyLoading.show();
        ApiResult mainGroupsResult = await requests.getSubCategories(
          mainGroup.id,
        );
        EasyLoading.dismiss();
        List<FieldModel> listOfTmpItems =
            FieldModel.listFromJson(mainGroupsResult.data);
        return await getLastField(
          await Get.dialog(
            GetFieldsForProfile(
              isFirst: false,
              fromCalls: false,
              list: listOfTmpItems,
              title: "گروه اصلی تخصصص های خود را انتخاب کنید",
            ),
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: false,
          ),
        );
      } else {
        EasyLoading.show();
        ApiResult mainGroupsResult = await requests.getSpecialities(
          mainGroup.id,
        );
        EasyLoading.dismiss();
        List<FieldModel> list = FieldModel.listFromJson(
          mainGroupsResult.data,
        );

        for (var speciality in list) {
          speciality.isSelected.value =
              listOfSubSubGroups.any((element) => element.id == speciality.id);
        }
        var res = await Get.dialog(
          GetLastFieldsWithSubGroups(
            listOfSpecialties: list,
            listOfSelectedSpecialties: listOfSubSubGroups,
            controller: this,
          ),
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: false,
        );
        if (res == 'get-back') {
          EasyLoading.show();

          print('listOfGroups.length');
          print(listOfGroups.length);
          print('listOfGroups.length');

          ApiResult mainGroupsResult = await requests.getSubCategories(
            (listOfGroups.length == 1)
                ? listOfGroups.first.id
                : listOfGroups[listOfGroups.length - 2].id,
          );
          EasyLoading.dismiss();
          List<FieldModel> listOfNewItems =
              FieldModel.listFromJson(mainGroupsResult.data);

          // if(listOfGroups.length != 1){
          listOfNewItems
              .singleWhere((element) => element.id == mainGroup.id)
              .isSelected
              .value = true;
          listOfGroups.removeLast();

          // }
          return await getLastField(
            await Get.dialog(
              GetFieldsForProfile(
                fromCalls: false,
                isFirst: false,
                list: listOfNewItems,
                title: "گروه اصلی تخصصص های خود را انتخاب کنید",
              ),
              barrierColor: Colors.black.withOpacity(0.5),
              barrierDismissible: false,
            ),
          );
        }
        return res;
      }
    }

    return FieldModel(
      id: 0,
      name: 'name',
      icon: 'icon',
      listOfSubItems: [],
      hasSubCategory: false,
      isSpeciality: false,
    );
  }

  void showSaveAlert() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: SaveAlertDialog(controller: this),
      ),
    );
  }

  void deleteFile({CustomFileModel? file}) async {
    EasyLoading.show();
    ApiResult result = await requests.deleteFile(file: file);
    EasyLoading.dismiss();

    if (result.isDone) {
      ViewUtils.showSuccessDialog('حذف نمونه کار شما با موفقیت انجام شد');
      listOfCvFiles.remove(file);
      update();
    } else {
      ViewUtils.showErrorDialog('حذف نمونه کار شما با خطا مواجه شد');
    }
  }

  void getDistricts(int cityId, bool fromOnInit) async {
    ApiResult result = await requests.getDistrictsByCity(cityId);
    if (result.isDone || true) {
      listOfDistricts = DistrictModel.listFromJson(result.data);
      if (listOfDistricts.isNotEmpty) {
        listOfDistricts.insert(
          0,
          DistrictModel(
            id: 0,
            name: 'حذف محدوده',
          ),
        );
      }
      if (fromOnInit) {
        for (var element in listOfDistricts) {
          if (element.id == Globals.userStream.user!.region!.id) {
            element.isSelected = true;
          }
        }
        // Globals.userStream.user!.region!.isSelected = true;
      }
      update();
    }
  }
}
