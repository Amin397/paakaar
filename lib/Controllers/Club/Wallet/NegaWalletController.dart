import 'package:paakaar/Models/Club/Wallet/UserWallet.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class NegaWalletController extends GetxController {
  List<UserWallet>? listOfUserWallets;
  final ClubRequestUtils requests = new ClubRequestUtils();
  RxBool isLoaded = false.obs;
  void getWallets() async {
    ApiResult result = await ClubRequestUtils.instance.getWallets();
    if (result.isDone) {
      this.listOfUserWallets = UserWallet.listFromJson(result.data);
      this.isLoaded.toggle();
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  @override
  void onInit() {
    this.getWallets();
    super.onInit();
  }
}
