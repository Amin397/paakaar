import 'package:paakaar/Models/AppIntroScreen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';

class AppIntroController extends GetxController {
  List<AppIntroScreenModel> listOfScreens = [];

  void getScreens() async {
    ApiResult result = await ProjectRequestUtils.instance.allIntroScreens();
    if (result.isDone) {
      this.listOfScreens = AppIntroScreenModel.listFromJson(
        result.data,
      );
      this.refresh();
    }
  }

  @override
  void onInit() {
    this.getScreens();
    super.onInit();
  }
}
