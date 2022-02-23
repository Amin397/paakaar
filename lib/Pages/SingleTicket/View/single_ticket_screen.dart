import 'package:flutter/material.dart';
import 'package:paakaar/Pages/SingleTicket/Controller/show_single_ticket_controller.dart';
import 'package:paakaar/Pages/Ticket/Model/ticket_room_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class ShowSingleTicketScreen extends StatelessWidget {
  ShowSingleTicketScreen({Key? key}) : super(key: key);
  final ShowSingleTicketController showSingleTicketController =
      Get.put(ShowSingleTicketController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              _buildChatHistory(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextBox() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 300.0) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AnimatedContainer(
                  constraints: BoxConstraints(maxHeight: Get.height * .15),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: ViewUtils.boxShadow(
                      blurRadius: 12.0,
                      spreadRadius: 8.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  duration: const Duration(milliseconds: 270),
                  child: TextField(
                    controller: showSingleTicketController.ticketTextController,
                    maxLines: 10,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: ColorUtils.mainRed,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showSingleTicketController.sendMessage(),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: Get.width / 8,
                  child: const Center(
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtils.red.shade700,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AnimatedContainer(
                  width: Get.width,
                  constraints: BoxConstraints(maxHeight: Get.height * .15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: ViewUtils.boxShadow(
                      blurRadius: 12.0,
                      spreadRadius: 8.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  duration: const Duration(milliseconds: 270),
                  child: TextField(
                    controller: showSingleTicketController.ticketTextController,
                    maxLines: 10,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showSingleTicketController.sendMessage(),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: Get.width / 8,
                  child: const Center(
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtils.red.shade700,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildChatHistory() {
    return GetBuilder(
      init: showSingleTicketController,
      builder: (ctx) => Expanded(
        child: Container(
          height: double.maxFinite,
          width: Get.width,
          child: ListView.builder(
            controller: showSingleTicketController.scrollController,
            itemCount: showSingleTicketController.model!.message!.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildSingleTicket(
              item: showSingleTicketController.model!.message![index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleTicket({Message? item}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 4.0,
      ),
      width: Get.width,
      constraints: BoxConstraints(
        maxWidth: Get.width * .6,
      ),
      child: Row(
        mainAxisAlignment:
            !item!.byAdmin! ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: !item.byAdmin!
                  ? ColorUtils.green.shade900
                  : ColorUtils.mainRed,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Column(
                crossAxisAlignment: !item.byAdmin!
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width / 1.5,
                    ),
                    child: Text(
                      item.message!,
                      // maxLines: 5,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (!item.byAdmin!)
                        const SizedBox(
                          width: 8.0,
                        ),
                      Text(
                        item.date!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 11.0,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      if (item.byAdmin!)
                        const SizedBox(
                          width: 8.0,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget _buildChatBox() {
//   return Align(
//     alignment: Alignment.bottomCenter,
//     child: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         if (constraints.maxWidth > 300.0) {
//           return AnimatedContainer(
//             margin: EdgeInsets.symmetric(
//               horizontal: Get.width * .02,
//               vertical: Get.height * .01,
//             ),
//             height: Get.height * .08,
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: ViewUtils.boxShadow(
//                 blurRadius: 12.0,
//                 spreadRadius: 8.0,
//               ),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             duration: const Duration(milliseconds: 270),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: double.maxFinite,
//                     height: Get.height * .15,
//                     child: TextField(
//                       controller:
//                           showSingleTicketController.ticketTextController,
//                       maxLines: 10,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                             width: 0.2,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: const BorderRadius.horizontal(
//                               right: Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                             color: ColorUtils.mainRed,
//                             width: 0.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => showSingleTicketController.sendMessage(),
//                   child: Container(
//                     width: Get.width / 8,
//                     child: const Center(
//                       child: Icon(
//                         Icons.send_outlined,
//                         color: Colors.white,
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         bottomLeft: Radius.circular(10.0),
//                       ),
//                       color: ColorUtils.red.shade700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return AnimatedContainer(
//             height: Get.height * .12,
//             width: Get.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: ViewUtils.boxShadow(
//                 blurRadius: 12.0,
//                 spreadRadius: 8.0,
//               ),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             duration: const Duration(milliseconds: 270),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: double.maxFinite,
//                     height: Get.height * .15,
//                     child: TextField(
//                       controller:
//                           showSingleTicketController.ticketTextController,
//                       maxLines: 10,
//                       decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.horizontal(
//                               right: Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                             color: Colors.transparent,
//                             width: 0.2,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.horizontal(
//                               right: Radius.circular(10.0)),
//                           borderSide: BorderSide(
//                             color: Colors.transparent,
//                             width: 0.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => showSingleTicketController.sendMessage(),
//                   child: Container(
//                     width: Get.width / 8,
//                     child: const Center(
//                       child: Icon(
//                         Icons.send_outlined,
//                         color: Colors.white,
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         bottomLeft: Radius.circular(10.0),
//                       ),
//                       color: ColorUtils.red.shade700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     ),
//   );
// }
}
