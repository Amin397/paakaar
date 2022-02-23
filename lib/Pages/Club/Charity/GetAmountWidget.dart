import 'package:flutter/material.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class GetAmountWidget extends StatefulWidget {
  final String title;
  final Function function;

  GetAmountWidget({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  _GetAmountWidgetState createState() => _GetAmountWidgetState();
}

class _GetAmountWidgetState extends State<GetAmountWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: Get.width,
            height: Get.height * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            "نیکوکاری",
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height / 16,
                ),
                Container(
                  width: Get.width / 1.2,
                  child: Text(
                    "مبلغ اهدایی به \n${this.widget.title}\n را وارد کنید",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ViewUtils.sizedBox(),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: Get.width / 1.5,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "مبلغ به تومان",
                    ),
                  ),
                ),
                Spacer(),
                this.submitButton(),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          // child: GestureDetector(
          //   onTap: () => Navigator.pop(context),
          //   child: Container(
          //     margin: EdgeInsets.only(
          //       top: Get.height / 4,
          //       left: Get.width / 18,
          //     ),
          //     child: Icon(
          //       Icons.close,
          //       color: Colors.grey,
          //       size: 25.0,
          //     ),
          //   ),
          // ),
          // ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: WidgetUtils.button(
        text: "پرداخت",
      ),
    );
  }
}
