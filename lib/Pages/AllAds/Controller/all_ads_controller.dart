import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/MainPage/main_ads_model.dart';
import 'package:paakaar/Pages/AllAds/View/get_categories_dialog.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class AllAdsController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<FieldModel> listOfFields = [];
  List<StateModel> listOfStates = [];

  // List<MainAdsModel> listOfAdsSpecial = [];
  // final PageController callOutPageController =
  //     PageController(viewportFraction: 1);

  RxBool isStatesLoaded = false.obs;
  RxBool isFieldsLoaded = false.obs;
  List<AdModel> list = [];
  List<AdModel> stateFiltered = [];

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }


  // Future<void> getAdsSlider() async {
  //   ApiResult result = await requests.dashboardAd();
  //   if (result.isDone) {
  //     listOfAdsSpecial = MainAdsModel.listFromJson(
  //       result.data,
  //     );
  //     isCallOutsLoaded.value = true;
  //   } else {
  //     ViewUtils.showErrorDialog();
  //   }
  // }

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
    selectField();
  }

  bool showStates = true;

  void getFilters() async {
    Get.dialog(
      GetCategoriesDialog(
        allAdsController: this,
      ),
    );
  }

  void makeStateActive(item) {
    listOfStates.forEach((element) {
      element.isSelected = false;
    });
    item.isSelected = true;
    showStates = false;
    unFocus();
    filterState(item);
    refresh();
  }

  void makeCityActive(item) {
    listOfStates
        .singleWhere((element) => element.isSelected)
        .listOfCities
        .forEach((element) {
      element.isSelected = false;
    });
    filterCity(item);
    item.isSelected = true;
    unFocus();
    refresh();
  }

  filterState(item) {
    List<AdModel> amin = [];
    if (item.id == 0) {
      list = listOfAds;
      stateFiltered = listOfAds;
    }else{
      for (var element in listOfAds) {
        if(element.state.id == item.id || element.state.id == 0){
          amin.add(element);
        }
      }
      list = amin;
      stateFiltered = amin;
    }
    update();
  }

  void filterCity(item) {
    List<AdModel> amin = [];
    if(item.id == 0){
      list = stateFiltered;
    }else{
      for (var element in listOfAds) {
        if (element.city.id == item.id || element.city.id == 0) {
          amin.add(element);
        }
      }
    list = amin;
    }
    update();
  }

  final FRefreshController refreshController = FRefreshController();
  List<AdModel> listOfAds = [];
  List<AdModel> listOfAdsSlider = [];

  void onAdPageChanged(int value) {
    adCurrentPage.value = value;
  }

  RxInt adCurrentPage = 0.obs;
  RxBool isCallOutsLoaded = false.obs;

  Future<void> getAds() async {
    ApiResult result = await requests.recentAds(
      fieldId: Get.arguments['field'].id.toString(),
    );
    if (result.isDone) {
      listOfAds = AdModel.listFromJson(
        result.data,
      );
      // list.add(listOfAds.singleWhere((element) => element.adType == 1));
      // for(var o in listOfAds){
      //   if(o.adType == 1){
      //     list.add(o);
      //   }else{
      //     listOfAdsSlider.add(o);
      //   }
      // }

      // list == listOfAds.singleWhere((element) => element.adType == 1).toList();
      // list = listOfAds;
      setSliderItem();

    } else {
      ViewUtils.showErrorDialog();
    }
    getStates();
  }

  @override
  void onInit() {
    // getAdsSlider();
    getAds();
    // getFields();
    super.onInit();
  }

  void setSliderItem() {
    for (var o in listOfAds) {
      if(o.adType == 2){
        listOfAdsSlider.add(o);
      }
    }
    // listOfAds.forEach((element) {
    //   if (element.adType == 2) {
    //     print('\n\n\n\n\n\n\n\n\n\n');
        // listOfAdsSlider.add(element);
      // }
    // });
    update();
  }

  setFieldItem({FieldModel? item}) {
    listOfFields.forEach((element) {
      element.isSelected.value = false;
    });
    item!.isSelected.value = true;

    update();
  }

  void selectField() {
    // print(listOfFields.singleWhere((element) => element.isSelected.value).id);

    List<AdModel> amin = [];

    // if(listOfFields.any((element) => element.isSelected.value)){

    // FieldModel model =
    // listOfFields.singleWhere((element) => element.isSelected.value);
    FieldModel model = Get.arguments['field'];
    // listOfFields.singleWhere((element) => element.isSelected.value);
    for (var element in listOfAds) {
      if (element.fieldId == model.id) {
        amin.add(element);

      }
    }

    list = amin;
    // }else{
    //   list = listOfAds;
    // }

    // listOfAds.forEach((element) {
    //   if(element.fieldId == model.id){
    //     listOfAds.add(element);
    //   }
    // });
    isCallOutsLoaded.value = true;
    update();
  }

  removeFilter() {
    listOfFields.forEach((element) {
      element.isSelected.value = false;
    });
    update();
  }
}
