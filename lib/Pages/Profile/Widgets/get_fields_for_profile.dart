import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class GetFieldsForProfile extends StatelessWidget {
  final List<FieldModel> list;

  bool isFirst = false;
  final bool isDirect ;
  final bool fromCalls ;
  final String title;

  GetFieldsForProfile({
    Key? key,
    required this.list,
    required this.isFirst,
    required this.fromCalls,
    required this.title, this.isDirect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(fromCalls){
          Get.close(1);
          Get.back();
        }else{
          Get.back();
        }
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Container(
            width: Get.width / 1.1,
            height: Get.height / 1.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(fromCalls){
                          Get.close(1);
                          Get.back();
                        }else{
                          Get.back();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Ionicons.close,
                          color: ColorUtils.textColor,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: buildField,
                    separatorBuilder: buildSeparator,
                    itemCount: list.length,
                  ),
                ),
                // ViewUtils.sizedBox(75),
                // Padding(
                //   padding:  EdgeInsets.symmetric(horizontal: 8.0),
                //   child: WidgetUtils.button(
                //     text: "ادامه",
                //     onTap: () {
                //   ),
                // ),
                ViewUtils.sizedBox(75),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(BuildContext context, int index) {
    FieldModel field = list[index];
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: ()async {
          final ProjectRequestUtils requests = ProjectRequestUtils();
          for (var element in list) {
            element.isSelected.value = false;
          }
          field.isSelected.value = true;
            Get.back(
              result: list.singleWhere((element) => element.isSelected.value),
            );

        },
        child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            height: Get.height / 24,
            child: Row(
              children: [
                if (!isDirect)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: field.isSelected.isTrue
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: field.isSelected.isTrue
                        ? ColorUtils.green
                        : ColorUtils.searchBackground,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  field.name,
                  style: const TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
                if (isDirect)
                  ...[
                    const Spacer(),
                    Icon(Icons.arrow_right,color: ColorUtils.myRed,),
                  ]
                // Spacer(),
                // Icon(
                //   Icons.arrow_right,
                //   color: ColorUtils.mainRed.withOpacity(0.8),
                // ),
              ],
            ),
          ),
      ),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    return Divider(
      color: ColorUtils.mainRed.withOpacity(0.5),
    );
  }
}
