import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class HealthInsuranceController extends GetxController {
  InsuranceBaseModel? basicInsurer;
  InsuranceBaseModel? relationship;
  InsuranceBaseModel? gender;

  late List<InsuranceBaseModel> basicInsurers;
  late List<InsuranceBaseModel> relationships;
  late List<InsuranceBaseModel> genders;

  RxBool isDataLoaded = false.obs;

  final ClubRequestUtils requests = ClubRequestUtils();

  @override
  void onInit() {
    this.getBaseData();
    super.onInit();
  }

  void getBaseData() async {
    ApiResult result = await this.requests.motorBaseData();
    if (result.isDone) {
      this.basicInsurers = InsuranceBaseModel.listFromJson(
        result.data['basicInsurers'],
      );
      this.relationships = InsuranceBaseModel.listFromJson(
        result.data['relationships'],
      );
      this.genders = InsuranceBaseModel.listFromJson(
        result.data['genders'],
      );

      this.isDataLoaded.value = true;
    }
  }
}
