import 'package:paakaar/Models/Club/Services/Insurance/InsuranceBaseModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';

class TravelPlusInsuranceController extends GetxController {
  InsuranceBaseModel? country;
  InsuranceBaseModel? duration;
  InsuranceBaseModel? plan;
  InsuranceBaseModel? gender;
  InsuranceBaseModel? visaType;

  late List<InsuranceBaseModel> countries;
  late List<InsuranceBaseModel> durations;
  late List<InsuranceBaseModel> plans;
  late List<InsuranceBaseModel> genders;
  late List<InsuranceBaseModel> visaTypes;

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
      this.countries = InsuranceBaseModel.listFromJson(
        result.data['countries'],
      );
      this.durations = InsuranceBaseModel.listFromJson(
        result.data['durations'],
      );
      this.plans = InsuranceBaseModel.listFromJson(
        result.data['plans'],
      );
      this.genders = InsuranceBaseModel.listFromJson(
        result.data['genders'],
      );
      this.visaTypes = InsuranceBaseModel.listFromJson(
        result.data['visaTypes'],
      );

      this.isDataLoaded.value = true;
    }
  }
}
