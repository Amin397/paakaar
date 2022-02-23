import 'package:paakaar/Models/Club/Services/VoucherCodes/VoucherCodeProviderModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:frefresh/frefresh.dart';

class VoucherCodeController extends GetxController {
  final ClubRequestUtils requests = ClubRequestUtils();
  int currentPage = 0;

  FRefreshController controller = FRefreshController();

  FRefreshController refreshController = new FRefreshController();

  RxInt page = 1.obs;
  List<VoucherCodeProviderModel>? listOfVoucherCodeProviders;
  RxBool isLoaded = false.obs;

  void onSearch(String string) {
    this.isLoaded.toggle();

    this.listOfVoucherCodeProviders!.forEach((element) {
      element.searchShow = false;

      if (element.name!.contains(string)) {
        element.searchShow = true;
      }
    });
    this.isLoaded.toggle();
  }

  Future<void> getVoucherCodes() async {
    this.isLoaded.value = false;

    ApiResult result =
        await ClubRequestUtils.instance.getAllVoucherCodeProviders();
    if (result.isDone && result.data != null) {
      this.listOfVoucherCodeProviders = (VoucherCodeProviderModel.listFromJson(
        result.data,
      ));
      this.isLoaded.toggle();
    } else {
      Get.back();
      ViewUtils.showErrorDialog();
    }
  }

  List<VoucherCodeProviderModel>? get getList => this
      .listOfVoucherCodeProviders
      ?.where((element) => element.searchShow)
      .toList();

  @override
  void onInit() {
    this.getVoucherCodes();
    super.onInit();
  }
}
