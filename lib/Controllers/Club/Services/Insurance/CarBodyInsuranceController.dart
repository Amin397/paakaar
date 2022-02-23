import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class CarBodyInsuranceController extends GetxController {
  InsuranceBaseModel? usingType;
  InsuranceCarBrand? brand;
  InsuranceCompany? company;
  InsuranceBaseModel? productionYear;
  InsuranceBaseModel? thirdPartyDiscount;
  InsuranceBaseModel? carBodyNoDamageYear;
  InsuranceBaseModel? bank;
  InsuranceBaseModel? coverage;

  late List<InsuranceBaseModel> usingTypes;
  late List<InsuranceCarBrand> brands;
  late List<InsuranceCompany> companies;
  late List<InsuranceBaseModel> productionYears;
  late List<InsuranceBaseModel> thirdPartyDiscounts;
  late List<InsuranceBaseModel> carBodyNoDamageYears;
  late List<InsuranceBaseModel> coverages;
  late List<InsuranceBaseModel> banks;

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
      this.brands = InsuranceCarBrand.listFromJson(
        result.data['Brands'],
      );
      this.thirdPartyDiscounts = InsuranceBaseModel.listFromJson(
        result.data['ThirdPartyDiscounts'],
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
      this.coverages = InsuranceBaseModel.listFromJson(
        result.data['Coverages'],
      );
      this.banks = InsuranceBaseModel.listFromJson(
        result.data['Banks'],
      );
      this.carBodyNoDamageYears = InsuranceBaseModel.listFromJson(
        result.data['CarBodyNoDamageYears'],
      );
      this.isDataLoaded.value = true;
    }
  }
}
