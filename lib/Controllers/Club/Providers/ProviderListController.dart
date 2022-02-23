import 'package:paakaar/Models/Club/CasteModel.dart';
import 'package:paakaar/Models/Club/ProviderModel.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:frefresh/frefresh.dart';

class ProviderListController extends GetxController {
  List<ProviderModel>? listOfProviders;
  final CasteModel caste;
  final WorkGroupModel workGroup;

  RxInt page = 0.obs;
  int totalCount = 0;

  final ScrollController scrollController = new ScrollController();
  double scrollOffset = 0.0;

  ProviderListController(
    this.workGroup,
    this.caste,
  );

  List<ProviderModel> get getList =>
      this.listOfProviders!.where((element) => element.searchShow).toList();

  RxBool isLoaded = false.obs;
  RxBool isLoading = false.obs;

  FRefreshController refreshController = new FRefreshController();

  Future<void> getProviders() async {
    this.isLoading.value = true;
    ApiResult result = await ClubRequestUtils.instance.allProviders(
      this.caste.id.toString(),
      this.page.value,
    );
    if (result.isDone) {
      if (this.listOfProviders == null) this.listOfProviders = [];
      this.listOfProviders?.addAll(
            ProviderModel.listFromJson(result.data['data']),
          );
      this.totalCount = result.data['totalCount'];
      this.isLoaded.value = true;
      this.isLoading.value = false;
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  void onChange(String string) {
    this.isLoaded.toggle();

    this.listOfProviders?.forEach(
          (element) => element.searchShow =
              element.name.contains(string) || string.isEmpty,
        );
    this.isLoaded.toggle();
  }

  @override
  void onInit() {
    this.getProviders();
    super.onInit();
  }
}
