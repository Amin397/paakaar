import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Pages/Support/View/build_ticket_room_widget.dart';
import 'package:paakaar/Pages/Ticket/Controller/ticket_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class SingleTicketScreen extends StatelessWidget {
  SingleTicketScreen({Key? key}) : super(key: key);
  final TicketController ticketController = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorUtils.myRed,
          onPressed: () {
            Get.toNamed(
              RoutingUtils.sendNewTicket.name,
              arguments: {'controller': ticketController},
            );
          },
          label: const Text(
            'ارسال تیکت جدید',
          ),
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: GetBuilder(
            init: ticketController,
            builder: (Object controller) {
              return AnimationLimiter(
                child: FRefresh(
                  headerHeight: Get.height / 8,
                  header: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Center(
                      child: WidgetUtils.loadingWidget(),
                    ),
                  ),
                  controller: ticketController.expertsRefreshController,
                  onRefresh: () async {
                    ticketController.getTicketData();
                    ticketController.expertsRefreshController.finishRefresh();
                  },
                  child: (ticketController.isLoaded.value)
                      ? (ticketController.ticketsRoomList.isNotEmpty)
                          ? GetBuilder(
                              init: ticketController,
                              builder: (ctx) => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    ticketController.ticketsRoomList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: BuildTicketRoomWidget(
                                          model: ticketController
                                              .ticketsRoomList[index],
                                          ticketController: ticketController,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: WidgetUtils.dataNotFound('تیکتی یافت نشد'),
                            )
                      : Center(
                          child: WidgetUtils.loadingWidget(),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
