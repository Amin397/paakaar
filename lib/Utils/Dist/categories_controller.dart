import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import '../routing_utils.dart';

class CategoriesController extends GetxController {
  RxBool isLoading = true.obs;
  List<FieldModel> listOfGroups = [];
  late FieldModel field;
  List<FieldModel> tmpList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProjectRequestUtils requests = ProjectRequestUtils();

  final FRefreshController refreshController = FRefreshController();

  Future<void> getNextLevel({
    bool refresh = false,
  }) async {
    ApiResult? result;

    isLoading.value = true;
    switch (listOfGroups.length) {
      case 0:
        result = await requests.getMainCategories(
          field.id,
        );
        break;
      default:
        if (listOfGroups.last.hasSubCategory) {
          result = await requests.getSubCategories(
            listOfGroups.last.id,
          );
        } else if (!listOfGroups.last.isSpeciality) {
          result = await requests.getSpecialities(
            listOfGroups.last.id,
          );
          // Get.toNamed(RoutingUtils.requestService.name, arguments: {
          //   'field': field,
          //   'type': 1,
          // });
        } else {
          isLoading.value = false;
          tmpList = listOfGroups;

          Get.toNamed(
            RoutingUtils.requestService.name,
            arguments: {
              'field': field,
              'type': Get.arguments['type'],
              'list':tmpList,
              'last':tmpList.last
            },
          );
            Future.delayed(const Duration(seconds: 1) , (){
              listOfGroups.removeLast();
              update();
            });
          // listOfLists.removeLast();
          return;
        }
    }

    if (result.isDone == true) {
      if (refresh) {
        listOfLists.removeLast();
      }
      listOfLists.add(
        FieldModel.listFromJson(result.data),
      );
      update();
      isLoading.value = false;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  RxBool isOptionsLoaded = false.obs;
  List<OptionModel> listOfOptions = [];

  void getPublicOptions() async {
    isOptionsLoaded.value = false;

    ApiResult result = await ProjectRequestUtils.instance.getPublicOptions(
      field.id,
    );

    if (result.isDone) {
      listOfOptions = OptionModel.listFromJson(
        result.data,
      );
      isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void getOptions() async {
    print('get options');
    isOptionsLoaded.value = false;

    ApiResult result = await ProjectRequestUtils.instance.getOptions(
      listOfGroups.last.id,
    );

    if (result.isDone) {
      listOfOptions.addAll(
        OptionModel.listFromJson(
          result.data,
          isPublic: false,
        ),
      );
      isOptionsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  List<List<FieldModel>> listOfLists = [];

  void deleteLast() {
    listOfGroups.removeLast();
    // if (listOfGroups.length > 0) {
    //   listOfGroups.removeLast();
    // }
    listOfLists.removeLast();
    isLoading.value = true;
    isLoading.value = false;
    update();
  }




  void goBack() {
    if (listOfLists.isNotEmpty) {
      listOfLists.removeLast();
      listOfGroups.removeLast();
      isLoading.value = true;
      Get.back();
      update();
    } else {
      // Get.close(1);
      // listOfLists.removeLast();
      // listOfGroups.removeLast();
      // isLoading.value = true;
      // isLoading.value = false;
      Get.back();
    }
  }

  // void getSubGroups({int delay = 200}) {
    // Future.delayed(Duration(milliseconds: delay), () async {
    //   await getNextLevel();
    //   await Get.dialog(
    //     GetFieldsAndGroupsDialog(
    //       field: field,
    //       controller: this,
    //     ),
    //     barrierDismissible: false,
    //     barrierColor: Colors.black.withOpacity(0.5),
    //   );
    //   getOptions();
    // });
  // }



  @override
  void onInit() {
    field = Get.arguments['field'];

    getPublicOptions();

    getNextLevel();
    // getSubGroups();
    super.onInit();
  }


}
