import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Pages/Ticket/Controller/new_ticket_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class SendNewTicketScreen extends StatelessWidget {
  SendNewTicketScreen({
    Key? key,
  }) : super(key: key);
  final NewTicketController newTicketController =
      Get.put(NewTicketController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
        ),
        body: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(
            vertical: Get.height * .01,
            horizontal: Get.width * .03,
          ),
          child: Column(
            children: [
              ViewUtils.sizedBox(),
              // ViewUtils.sizedBox(),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'عنوان',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
              ViewUtils.sizedBox(80),
              AnimatedContainer(
                constraints: BoxConstraints(
                    maxHeight: Get.height * .1
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                duration: const Duration(milliseconds: 270),
                child: TextField(
                  controller: newTicketController.titleController,
                  maxLines: 10,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: ColorUtils.black.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: ColorUtils.orange,
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: Get.width,
              //   // height: Get.height * .05,
              //   child: TextField(
              //     controller: newTicketController.titleController,
              //     // maxLines: 2,
              //     decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         borderSide: BorderSide(
              //           color: ColorUtils.black.withOpacity(0.2),
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         borderSide: const BorderSide(
              //           color: ColorUtils.orange,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              ViewUtils.sizedBox(),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'پیام',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
              ViewUtils.sizedBox(70),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: TextField(
                            controller: newTicketController.messageController,
                            maxLines: 20,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: ColorUtils.black.withOpacity(0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: ColorUtils.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      ViewUtils.sizedBox(),
                      GestureDetector(
                        onTap: () {
                          newTicketController.sendTicket();
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height * .05,
                          decoration: BoxDecoration(
                            color: ColorUtils.green,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Center(
                            child: AutoSizeText(
                                "ارسال تیکت",
                              maxLines: 1,
                              maxFontSize: 18.0,
                              minFontSize: 14.0,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
