import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/Services/show_alert_modal/show_call_out_alert.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Models/Locations/DistrictModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_filters_dialog.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_option_values_widget.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_state_and_city_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/upgrade_plan_dialog.dart';

class RequestServiceController extends GetxController {
  late FieldModel field;
  RxBool isLoading = true.obs;
  final ProjectRequestUtils requests = ProjectRequestUtils();
  List<UserModel> listOfExperts = [];
  List<CallModel> listOfCallOuts = [];
  RxBool isDataLoaded = false.obs;

  List<CallModel> callList = [];
  List<CallModel> stateFiltered = [];

  late GetPage targetPage;
  late String title;
  bool showAddCallOutButton = false;

  bool showStates = true;

  final FRefreshController expertsRefreshController = FRefreshController();
  final FRefreshController callOutsRefreshController = FRefreshController();

  final TextEditingController searchTextController = TextEditingController();

  RxBool isOptionsLoaded = false.obs;
  List<OptionModel> listOfOptions = [];
  List<FieldModel> listOfGroups = [];

  Object? specialitiesId;

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  List<StateModel> listOfStates = [];
  List<DistrictModel> listOfDistricts = [];
  RxBool isStatesLoaded = false.obs;

  String displayDistrict(p1) {
    return p1.name;
  }

  void makeDistrictActive(item) {
    for (var element in listOfDistricts) {
      element.isSelected = false;
    }
    // item.isSelected = !item.isSelected;
    item.isSelected = true;
    // if (item.id == 0) {
    //   listOfDistricts = [];
    // }
    unFocus();
    update();
  }

  String displayDistrict1(p1) {
    return p1.name;
  }

  void getStates() async {
    ApiResult result = await ProjectRequestUtils.instance.allStatesAndCities();
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
      // listOfStates.first.isSelected = true;
      isStatesLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  List<List<FieldModel>> listOfLists = [];

  void getOptions() async {
    if (listOfGroups.isNotEmpty) {
      isOptionsLoaded.value = false;
      List<int> ids = [listOfGroups.last.id];

      ApiResult result =
          await ProjectRequestUtils.instance.getOptionsByListOfIds(
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
    } else {
      isOptionsLoaded.value = true;
    }
  }

  void goBack() {
    if (listOfLists.isNotEmpty) {
      listOfLists.removeLast();
      listOfGroups.removeLast();
      isLoading.value = true;
      Get.back();
      update();
    } else {
      // Get.close(1);
      // listOfLists.removeLast();
      // listOfGroups.removeLast();
      // isLoading.value = true;
      // isLoading.value = false;
      Get.back();
    }
  }

  void makeStateActive(item) {
    for (var element in listOfStates) {
      element.isSelected = false;
    }
    item.isSelected = true;

    showStates = false;
    unFocus();
    filterState(item);
    refresh();
  }

  filterState(item) {
    List<CallModel> amin = [];
    if (item.id == 0) {
      callList = listOfCallOuts;
      stateFiltered = listOfCallOuts;
      listOfDistricts.clear();
    } else {
      for (var element in listOfCallOuts) {
        if (element.state.id == item.id || element.state.id == 0) {
          amin.add(element);
        }
      }
      callList = amin;
      stateFiltered = amin;
    }
    update();
  }

  // void makeStateActive(item) {
  //   for (var element in listOfStates) {
  //     element.isSelected = false;
  //   }
  //   item.isSelected = true;
  //   showStates = false;
  //   listOfDistricts = [];
  // if (item.id != 0) {
  //   listOfCallOuts.map((e) => e.state.id == item.id).toList();
  // }
  // item.listOfCities.map((e) => e.isSelected = false).toList();
  // unFocus();
  // refresh();
  // }

  void makeCityActive(item) {
    listOfStates
        .singleWhere((element) => element.isSelected)
        .listOfCities
        .forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;
    if (!showAddCallOutButton) {
      getDistricts(
        item.id,
      );
    }
    unFocus();
    refresh();
  }

  void getDistricts(int cityId) async {
    ApiResult result = await requests.getDistrictsByCity(cityId);
    if (result.isDone || true) {
      listOfDistricts = DistrictModel.listFromJson(result.data);
      if (listOfDistricts.isNotEmpty) {
        listOfDistricts.insert(
          0,
          DistrictModel(id: 0, name: 'همه ی محدوده ها'),
        );
      }
      update();
    }
  }

  List<UserModel> get getListOfExperts {
    if (showAddCallOutButton) return [];
    List<UserModel> list = listOfExperts;

    print('*****************${listOfGroups.length}');
    switch (listOfGroups.length) {
      case 0:
        print('case 0');

        list = listOfExperts
            .where((element) =>
                element.fields!.any((element) => element.id == field.id))
            .toList();
        break;
      case 1:
        print('case 1');
        list = listOfExperts
            .where((element) => element.categories!
                .any((element) => element.id == listOfGroups.first.id))
            .toList();
        break;

      case 2:
        {
          print('case 2');
          list = listOfExperts
              .where((element) => element.specialities?.any((element) => element.id == listOfGroups[1].id) ?? false)
              .toList();
          break;
        }
      case 3:
        print('case 3');
        list = listOfExperts
            .where((element) => element.specialities!
                .any((element) => element.id == listOfGroups[2].id))
            .toList();
        break;
    }
    list = list.where((element) => element.searchShow).toList();

    if (listOfStates.any((element) => element.isSelected) &&
        listOfStates.singleWhere((element) => element.isSelected).id > 0) {
      List<int> listOfCityIds = listOfStates
          .singleWhere((element) => element.isSelected)
          .listOfCities
          .where((element) => element.isSelected)
          .map((e) => e.id)
          .toList();
      if (listOfCityIds.isNotEmpty && !listOfCityIds.contains(0)) {
        list = list
            .where((element) =>
                listOfCityIds.contains(element.city?.id) ||
                element.city?.id == 0)
            .toList();
        list = list
            .where((element) =>
                element.state?.id ==
                listOfStates.singleWhere((element) => element.isSelected).id)
            .toList();
      } else {
        list = list
            .where((element) =>
                element.state?.id ==
                listOfStates.singleWhere((element) => element.isSelected).id)
            .toList();
      }
    }

    if (listOfDistricts.any((element) => element.isSelected) &&
        listOfDistricts.singleWhere((element) => element.isSelected).id > 0) {
      // List<int> listOfDistricts = listOfStates
      //     .singleWhere((element) => element.isSelected)
      //     .listOfCities
      //     .where((element) => element.isSelected)
      //     .map((e) => e.id)
      //     .toList();

      List<int> listOfDistrictsIds = listOfDistricts
          .where((element) => element.isSelected)
          .map((e) => e.id)
          .toList();
      if (listOfDistrictsIds.isNotEmpty && !listOfDistrictsIds.contains(0)) {
        list = list
            .where((element) =>
                listOfDistrictsIds.contains(element.region?.id) ||
                element.region?.id == 0)
            .toList();
        list = list
            .where((element) =>
                element.region?.id ==
                listOfDistricts.singleWhere((element) => element.isSelected).id)
            .toList();
      } else {
        list = list
            .where((element) =>
                element.region?.id ==
                listOfDistricts.singleWhere((element) => element.isSelected).id)
            .toList();
      }
    }

    listOfOptions.where((element) => element.isSelected).forEach((element) {
      if (element.isPublic) {
        list = list.where((callOut) {
          OptionValue optionValue = element.values
              .singleWhere((optionValue) => optionValue.isSelected.isTrue);
          Map items = {};
          callOut.listOfPublicFilters?.forEach((pFilter) {
            items[pFilter.id.toString()] = pFilter.values
                .singleWhere((pFilterValue) => pFilterValue.isSelected.isTrue)
                .id;
          });
          return items.containsKey(element.id.toString()) &&
              items[element.id.toString()] == optionValue.id;
        }).toList();
      } else {
        list = list.where((callOut) {
          OptionValue optionValue = element.values
              .singleWhere((optionValue) => optionValue.isSelected.isTrue);
          Map items = {};
          callOut.listOfOptions?.forEach((pFilter) {
            items[pFilter.id.toString()] = pFilter.values
                .singleWhere((pFilterValue) => pFilterValue.isSelected.isTrue)
                .id;
          });

          return items.containsKey(element.id) &&
              items[element.id.toString()] == optionValue.id;
        }).toList();
      }
    });
    list = list.where((element) => element.searchShow).toList();
    return list;
  }

  List<CallModel> get getListOfCallOuts {
    if (!showAddCallOutButton) return [];
    List<CallModel> list = listOfCallOuts;
    UserModel user = Globals.userStream.user!;

    list = list.where((element) {
      return user.specialities
              ?.map((e) => e.id)
              .contains(element.speciality?.id) ==
          true;
    }).toList();
    list = list.where((element) => element.searchShow).toList();

    if (listOfStates.any((element) => element.isSelected) &&
        listOfStates.singleWhere((element) => element.isSelected).id > 0) {
      List<int> listOfCityIds = listOfStates
          .singleWhere((element) => element.isSelected)
          .listOfCities
          .where((element) => element.isSelected)
          .map((e) => e.id)
          .toList();
      if (listOfCityIds.isNotEmpty && !listOfCityIds.contains(0)) {
        list = list
            .where((element) =>
                listOfCityIds.contains(element.city.id) || element.city.id == 0)
            .toList();
        list = list
            .where((element) =>
                element.state.id ==
                listOfStates.singleWhere((element) => element.isSelected).id)
            .toList();
      } else {
        list = list
            .where((element) =>
                element.state.id ==
                listOfStates.singleWhere((element) => element.isSelected).id)
            .toList();
      }
    }

    listOfOptions.where((element) => element.isSelected).forEach(
      (element) {
        if (element.isPublic) {
          list = list.where(
            (callOut) {
              OptionValue optionValue = element.values.singleWhere(
                (optionValue) => optionValue.isSelected.isTrue,
              );
              Map items = {};
              callOut.listOfPublicFilters?.forEach(
                (pFilter) {
                  items[pFilter.id.toString()] = pFilter.values
                      .singleWhere(
                          (pFilterValue) => pFilterValue.isSelected.isTrue)
                      .id;
                },
              );
              return items.containsKey(element.id.toString()) &&
                  items[element.id.toString()] == optionValue.id;
            },
          ).toList();
        } else {
          list = list.where(
            (callOut) {
              OptionValue optionValue = element.values
                  .singleWhere((optionValue) => optionValue.isSelected.isTrue);
              Map items = {};
              callOut.listOfOptions?.forEach(
                (pFilter) {
                  items[pFilter.id.toString()] = pFilter.values
                      .singleWhere(
                          (pFilterValue) => pFilterValue.isSelected.isTrue)
                      .id;
                },
              );
              return items.containsKey(element.id) &&
                  items[element.id.toString()] == optionValue.id;
            },
          ).toList();
        }
      },
    );
    return list;
  }

  set type(type) {
    if (type == 1) {
      targetPage = RoutingUtils.expertList;
      title = "مشاهده خدمات و عوامل مربوط به ${field.name}";
    } else {
      title = "فراخوان های مرتبط با تخصص شما";
      showAddCallOutButton = true;
      targetPage = RoutingUtils.addCallOut;
    }
  }

  @override
  void onInit() async {
    getStates();
    field = Get.arguments['field']!;
    type = Get.arguments['type']!;

    // print();
    if (Get.arguments['type'] == 1) {
      listOfGroups.addAll(Get.arguments['list']);
    }
    // getNextLevel();

    if (showAddCallOutButton) {
      if (Globals.userStream.user!.role!.isSpecial == false ||
          Globals.userStream.user?.isExpired == true ||
          Globals.userStream.user?.role?.membershipId == 1) {
        showUpgradePlanDialog();
      }
      isDataLoaded.value = true;
      listOfCallOuts = [];
      if (Globals.userStream.user!.specialities!.isNotEmpty) {
        field = Globals.userStream.user!.specialities!.last;
      }
      selectGroupsByUser();
      if (Globals.userStream.user!.specialities!.isNotEmpty) {
        getCallOuts(
          refresh: false,
        );
      }
      // getExperts();
    } else {
      specialitiesId = Get.arguments['last'].id;
      getExperts();
      // getCallOuts();
      // selectGroupsByUser();
      // getSubGroups();
    }
    getOptions();

    super.onInit();
  }

  void showUpgradePlanDialog() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        Get.dialog(
          UpgradePlanDialog(
            text: Globals.userStream.user?.isExpired == true
                ? "تاریخ عضویت شما به پایان رسیده است"
                : "فراخوان ها فقط برای کاربران ویژه قابل نمایش هستند\n ولی همه کاربران (عادی_ویژه)میتوانند فراخوان دهند ",
            fromDashboard: false,
          ),
          barrierColor: ColorUtils.black.withOpacity(0.5),
          barrierDismissible: Globals.userStream.user?.isExpired == false,
        );
      },
    );
  }

  selectGroupsByUser() {
    UserModel userModel = Globals.userStream.user!;
    // listOfLists.add(
    //       userModel.fields!,
    //     );
    // listOfLists.add(
    //       userModel.mainGroups!,
    //     );
    // listOfGroups.add(
    //       userModel.mainGroups!.first,
    //     );
    // listOfLists.add(
    //       userModel.mainSubGroups!,
    //     );
    //
    // listOfGroups.addAll(
    //       userModel.mainSubGroups!,
    //     );
    // listOfLists.add(
    //       userModel.mainSubSubGroups!,
    //     );

    listOfGroups.addAll(
      userModel.specialities!,
    );
    update();
  }

  // void getSubGroups({int delay = 200}) {
  //   Future.delayed(Duration(milliseconds: delay), () async {
  //     await this.getNextLevel();
  //     await Get.dialog(
  //       GetFieldsAndGroupsDialog(
  //         field: field,
  //         controller: this,
  //         showButton: this.showAddCallOutButton,
  //       ),
  //       barrierDismissible: false,
  //       barrierColor: Colors.black.withOpacity(0.5),
  //     );
  //     this.getOptions();
  //   });
  // }

  Future<void> getExperts() async {
    ApiResult result = await requests.getIndividualsInField(
      field.id,
    );

    if (result.isDone) {
      print('*******************');
      List<UserModel> testList = [];
      testList = UserModel.listFromJson(
        result.data,
      );

      listOfExperts = testList
          .where((element) => element.specialities!
              .any((element) => element.id == specialitiesId))
          .toList();

      // testList.forEach((element) {
      //   if(element.fields!.last.id == field.id){
      //     listOfExperts.add(element);
      //   }
      // });

      isDataLoaded.value = true;
      update();
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  Future<void> getCallOuts({bool? refresh}) async {
    List<int> ids =
        Globals.userStream.user!.specialities!.map((e) => e.id).toList();
    ApiResult result = await requests.getCallOuts(
      ids,
    );

    if (result.isDone) {
      if (refresh!) {
        listOfCallOuts.clear();
        for (var o in result.data) {
          listOfCallOuts.insert(0, CallModel.fromJson(o));
        }
      } else {
        for (var o in result.data) {
          listOfCallOuts.insert(0, CallModel.fromJson(o));
        }
      }
      // listOfCallOuts = CallModel.listFromJson(
      //   result.data,
      // );
      isDataLoaded.value = true;
      update();
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

  void getCityAndState() {
    Get.bottomSheet(
      GetStateAndCityWidget(
        controller: this,
      ),
    );
  }

  void getFilters() async {
    Get.dialog(
      GetFiltersDialog(
        controller: this,
      ),
    );
  }

  void onSearch(String string) {
    if (showAddCallOutButton) {
      for (var element in listOfCallOuts) {
        element.searchShow = element.name.contains(string);
      }
    } else {
      for (var element in listOfExperts) {
        element.searchShow = element.fullName.contains(string);
      }
    }
    update();
  }

  void getCanAddCall() async {
    EasyLoading.show();
    ApiResult result = await requests.getCanAddCall();
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data is int) {
        if (result.data == 0) {
          deleteMessageAlert(
            message: 'با توجه به درجه عضویت شما امکان ثبت فراخوان رایگان دارید',
            id: 0,
          );
        } else {
          deleteMessageAlert(
            message:
                '  تعداد فراخوان های رایگان شما به پایان رسیده و برای ثبت فراخوان جدید باید ' +
                    result.data.toString() +
                    ' تومان پرداخت کنید',
            id: 1,
          );
        }
      } else {
        deleteMessageAlert(
          message:
              'متاسفانه شما به علت اتمام تعداد فراخوان های رایگان و غیر رایگان امکان ثبت فراخوان ندارید',
          id: 2,
        );
      }
    }
  }

  void deleteMessageAlert({String? message, int? id}) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: ShowCallOutAlert(
          message: message,
          id: id,
          field: field,
        ),
      ),
    ).then((value) {
      if (!value['back']) {
        if (id != 2) {
          Get.toNamed(
            RoutingUtils.addCallOut.name,
            arguments: {
              'field': field,
            },
          );
        }
      }
    });
  }
}
