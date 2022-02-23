import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class MotorInsuranceController extends GetxController {
  InsuranceBaseModel? coverageType;
  InsuranceBaseModel? motorType;
  InsuranceBaseModel? thirdPartyDiscount;
  InsuranceBaseModel? driverDiscount;
  InsuranceBaseModel? lifeLoss;
  InsuranceBaseModel? propertyLoss;
  InsuranceBaseModel? driverLoss;
  InsuranceCompany? company;
  InsuranceBaseModel? productionYear;
  InsuranceBaseModel? duration;
  InsuranceBaseModel? insuranceStatus;

  late List<InsuranceBaseModel> coverageTypes;
  late List<InsuranceBaseModel> motorTypes;
  late List<InsuranceBaseModel> thirdPartyDiscounts;
  late List<InsuranceBaseModel> driverDiscounts;
  late List<InsuranceBaseModel> lifeLosses;
  late List<InsuranceBaseModel> propertyLosses;
  late List<InsuranceBaseModel> driverLosses;
  late List<InsuranceCompany> companies;
  late List<InsuranceBaseModel> productionYears;
  late List<InsuranceBaseModel> durations;
  late List<InsuranceBaseModel> insuranceStatuses;

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
      this.coverageTypes = InsuranceBaseModel.listFromJson(
        result.data['CoverageTypes'],
      );
      this.motorTypes = InsuranceBaseModel.listFromJson(
        result.data['MotorTypes'],
      );
      this.thirdPartyDiscounts = InsuranceBaseModel.listFromJson(
        result.data['ThirdPartyDiscounts'],
      );
      this.driverDiscounts = InsuranceBaseModel.listFromJson(
        result.data['DriverDiscounts'],
      );
      this.lifeLosses = InsuranceBaseModel.listFromJson(
        result.data['LifeLosses'],
      );
      this.propertyLosses = InsuranceBaseModel.listFromJson(
        result.data['PropertyLosses'],
      );
      this.driverLosses = InsuranceBaseModel.listFromJson(
        result.data['DriverLosses'],
      );
      this.companies = InsuranceCompany.listFromJson(
        result.data['Companies'],
      );
      this.productionYears = InsuranceBaseModel.listFromJson(
        result.data['ProductionYears'],
      );
      this.durations = InsuranceBaseModel.listFromJson(
        result.data['Durations'],
      );
      this.insuranceStatuses = InsuranceBaseModel.listFromJson(
        result.data['InsuranceStatuses'],
      );
      this.isDataLoaded.value = true;
    }
  }
}
