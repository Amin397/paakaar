import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Pages/Ticket/Controller/ticket_controller.dart';
import 'package:paakaar/Pages/Ticket/Model/ticket_room_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class BuildTicketRoomWidget extends StatelessWidget {
  BuildTicketRoomWidget({Key? key, this.model, this.ticketController})
      : super(key: key);
  TicketRoomModel? model;
  final TicketController? ticketController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ticketController,
      builder: (ctx) => InkWell(
        onTap: () {
          if (model!.isClosed == 0) {
            Get.toNamed(
              RoutingUtils.showSingleTicket.name,
              arguments: {
                'model': model,
              },
            );
          } else {
            ViewUtils.showErrorDialog(
              'تیکت مورد نظر بسته شده است',
            );
          }
        },
        onLongPress: () {
          // if (model!.isClosed == 0) {
            ticketController!.deleteMessageAlert(model: model);
          // }
        },
        child: Container(
          width: Get.width,
          height: Get.height * .25,
          margin: EdgeInsets.symmetric(
            vertical: Get.height * .01,
            horizontal: Get.width * .02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5.0,
              )
            ],
          ),
          child: Row(
            children: [
              (model!.isClosed == 1)
                  ? Container(
                      width: Get.width * .06,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: ColorUtils.myRed,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                        ),
                      ),
                      child: const RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: AutoSizeText(
                            'بسته شده',
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
                    )
                  : Container(),
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Flexible(
                        flex:1,
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: AutoSizeText(
                                  'عنوان تیکت :',
                                  maxFontSize: 14.0,
                                  maxLines: 1,
                                  minFontSize: 10.0,
                                  style: TextStyle(
                                    color: ColorUtils.textColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),

                              Expanded(
                                child: Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: AutoSizeText(
                                    model!.title,
                                    maxFontSize: 16.0,
                                    // maxLines: 2,
                                    minFontSize: 10.0,
                                    style: TextStyle(
                                      color: ColorUtils.textColor,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Flexible(
                        flex:1,
                        child: Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      AutoSizeText(
                                        'آخرین تیکت از طرف : ',
                                        maxLines: 1,
                                        maxFontSize: 12.0,
                                        minFontSize: 8.0,
                                        style: TextStyle(
                                          color: ColorUtils.textColor,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      AutoSizeText(
                                        (model!.message!.first.byAdmin!)
                                            ? 'ادمین'
                                            : 'شما',
                                        maxLines: 2,
                                        maxFontSize: 14.0,
                                        minFontSize: 10.0,
                                        style: TextStyle(
                                          color: ColorUtils.textColor,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AutoSizeText(
                                      model!.message!.last.message,
                                      maxFontSize: 16.0,
                                      minFontSize: 10.0,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ColorUtils.textColor,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.maxFinite,
                width: Get.width * .1,
                child: Center(
                  child: Icon(
                    Icons.arrow_right_outlined,
                    color: ColorUtils.myRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
