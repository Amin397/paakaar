import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Pages/RequestService/Widgets/get_option_values_widget.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';

class ExpertListController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();
  late final FieldModel lastField;

  late List<OptionModel> listOfOptions;
  late List<UserModel> listOfExperts;
  late List<StateModel> listOfStates;
  RxBool isOptionsLoaded = false.obs;
  RxBool isIndividualsLoaded = false.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    this.lastField = Get.arguments['lastField']!;
    this.getOptions();
    this.getExperts();
    super.onInit();
  }

  void getOptions() async {
    ApiResult result = await this.requests.getOptions(
          this.lastField.id,
        );

    if (result.isDone) {
      this.listOfOptions = OptionModel.listFromJson(
        result.data,
      );
      this.isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getExperts() async {
    ApiResult result = await this.requests.getIndividualsBySubSubGroupId(
          this.lastField.id,
        );

    if (result.isDone) {
      this.listOfExperts = UserModel.listFromJson(
        result.data,
      );
      this.isIndividualsLoaded.value = true;
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

  void getCityAndState() async {
    // EasyLoading.show();
    // ApiResult result = await this.requests.allStatesAndCities();
    // EasyLoading.dismiss();
    //
    // if (result.isDone) {
    //   this.listOfStates = StateModel.listFromJson(result.data);
    //   Get.bottomSheet(
    //     GetStateAndCityWidget(
    //       expertListController: this,
    //     ),
    //   );
    // } else {
    //   ViewUtils.showErrorDialog();
    // }
  }
}
