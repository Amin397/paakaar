import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class ThirdPersonInsuranceController extends GetxController {
  InsuranceBaseModel? coverageType;
  InsuranceCarBrand? brand;
  InsuranceBaseModel? thirdPartyDiscount;
  InsuranceBaseModel? driverDiscount;
  InsuranceBaseModel? lifeLoss;
  InsuranceBaseModel? propertyLoss;
  InsuranceBaseModel? driverLoss;
  InsuranceCompany? company;
  InsuranceBaseModel? productionYear;
  InsuranceBaseModel? usingType;
  InsuranceBaseModel? duration;
  InsuranceBaseModel? insuranceStatus;
  InsuranceBaseModel? vehicleCategory;

  late List<InsuranceBaseModel> coverageTypes;
  late List<InsuranceCarBrand> brands;
  late List<InsuranceBaseModel> thirdPartyDiscounts;
  late List<InsuranceBaseModel> driverDiscounts;
  late List<InsuranceBaseModel> lifeLosses;
  late List<InsuranceBaseModel> propertyLosses;
  late List<InsuranceBaseModel> driverLosses;
  late List<InsuranceCompany> companies;
  late List<InsuranceBaseModel> productionYears;
  late List<InsuranceBaseModel> usingTypes;
  late List<InsuranceBaseModel> durations;
  late List<InsuranceBaseModel> insuranceStatuses;
  late List<InsuranceBaseModel> vehicleCategories;

  RxBool isDataLoaded = false.obs;

  final ClubRequestUtils requests = ClubRequestUtils();

  @override
  void onInit() {
    this.getBaseData();
    super.onInit();
  }

  void getBaseData() async {
    ApiResult result = await this.requests.thirdPartyBaseData();
    if (result.isDone) {
      this.coverageTypes = InsuranceBaseModel.listFromJson(
        result.data['CoverageTypes'],
      );
      this.brands = InsuranceCarBrand.listFromJson(
        result.data['Brands'],
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
      this.usingTypes = InsuranceBaseModel.listFromJson(
        result.data['UsingTypes'],
      );
      this.durations = InsuranceBaseModel.listFromJson(
        result.data['Durations'],
      );
      this.insuranceStatuses = InsuranceBaseModel.listFromJson(
        result.data['InsuranceStatuses'],
      );
      this.vehicleCategories = InsuranceBaseModel.listFromJson(
        result.data['VehicleCategories'],
      );
      this.isDataLoaded.value = true;
    }
  }
}
