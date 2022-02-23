import 'package:paakaar/Models/Club/CasteModel.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class CastesController extends GetxController {
  final WorkGroupModel workGroup;
  CastesController(this.workGroup);

  List<CasteModel>? listOfCastes;
  RxBool isLoaded = false.obs;

  List<CasteModel> get getList =>
      this.listOfCastes!.where((element) => element.searchShow).toList();

  void onSearch(String string) {
    this.isLoaded.toggle();
    this.listOfCastes!.forEach(
          (element) => element.searchShow =
              element.name.contains(string) || string.isEmpty,
        );
    this.isLoaded.toggle();
  }

  Future<void> getCastes() async {
    ApiResult result = await ClubRequestUtils.instance.allCastes(
      this.workGroup.id.toString(),
    );
    if (result.isDone) {
      this.listOfCastes = CasteModel.listFromJson(result.data);
      this.isLoaded.toggle();
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  @override
  void onInit() {
    this.getCastes();
    super.onInit();
  }
}
