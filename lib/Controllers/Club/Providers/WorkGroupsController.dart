import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class WorkGroupsController extends GetxController {
  List<WorkGroupModel>? listOfWorkGroups;

  RxBool isLoaded = false.obs;

  final ClubRequestUtils requests = new ClubRequestUtils();

  List<WorkGroupModel> get getList =>
      this.listOfWorkGroups!.where((element) => element.searchShow).toList();
  Future<void> getGroups() async {
    ApiResult result = await ClubRequestUtils.instance.allWorkGroups();
    if (result.isDone) {
      this.listOfWorkGroups = WorkGroupModel.listFromJson(result.data);
      this.isLoaded.toggle();
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  void onSearch(String string) {
    this.isLoaded.toggle();
    this.listOfWorkGroups!.forEach(
          (element) => element.searchShow =
              element.name.contains(string) || string.isEmpty,
        );
    this.isLoaded.toggle();
  }

  @override
  void onInit() {
    this.getGroups();
    super.onInit();
  }
}
