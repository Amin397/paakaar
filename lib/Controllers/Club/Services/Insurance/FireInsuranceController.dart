import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class FireInsuranceController extends GetxController {
  InsuranceBaseModel? areaUnitPrice;
  InsuranceBaseModel? coverage;
  InsuranceBaseModel? estateType;
  InsuranceBaseModel? structureType;
  InsuranceBaseModel? ownershipType;

  late List<InsuranceBaseModel> areaUnitPrices;
  late List<InsuranceBaseModel> coverages;
  late List<InsuranceBaseModel> estateTypes;
  late List<InsuranceBaseModel> structureTypes;
  late List<InsuranceBaseModel> ownershipTypes;

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
      this.areaUnitPrices = InsuranceBaseModel.listFromJson(
        result.data['areaUnitPrices'],
      );
      this.coverages = InsuranceBaseModel.listFromJson(
        result.data['coverages'],
      );
      this.estateTypes = InsuranceBaseModel.listFromJson(
        result.data['estateTypes'],
      );
      this.structureTypes = InsuranceBaseModel.listFromJson(
        result.data['structureTypes'],
      );
      this.ownershipTypes = InsuranceBaseModel.listFromJson(
        result.data['ownershipTypes'],
      );

      this.isDataLoaded.value = true;
    }
  }
}
