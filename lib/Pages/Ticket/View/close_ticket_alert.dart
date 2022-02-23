import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Pages/Ticket/Controller/ticket_controller.dart';
import 'package:paakaar/Pages/Ticket/Model/ticket_room_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';


class CloseTicketAlert extends StatelessWidget {
  const CloseTicketAlert({Key? key , this.controller , this.model}) : super(key: key);
  final TicketController? controller;

  final TicketRoomModel? model;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .25,
      width: Get.width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('! توجه'),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              'برای بستن این تیکت مطمئنید؟',
              maxFontSize: 16.0,
              maxLines: 3,
              textAlign: TextAlign.right,
              minFontSize: 12.0,
              style: TextStyle(
                color: ColorUtils.textColor,
                fontSize: 14.0,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height * .055,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            controller!.closeTicket(model: model);
                          },
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * .04,
                              vertical: Get.height * .008,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ],
                              color: ColorUtils.green,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: AutoSizeText(
                                'بستن تیکت',
                                maxLines: 1,
                                maxFontSize: 14.0,
                                minFontSize: 10.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            controller!.deleteTicket(model: model);
                          },
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * .04,
                              vertical: Get.height * .008,
                            ),

                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ],
                              color: ColorUtils.myRed,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: AutoSizeText(
                                'حذف تیکت',
                                maxLines: 1,
                                maxFontSize: 14.0,
                                minFontSize: 10.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'بازگشت',
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
