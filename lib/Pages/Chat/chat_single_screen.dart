import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Chat/chat_single_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Chat/messages_model.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class ChatSingleScreen extends StatelessWidget {
  final ChatSingleController controller = Get.put(
    ChatSingleController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        backgroundColor: Colors.white,
        body: buildBody(),
      ),
    );
  }

  Widget buildUser() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 300.0) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => ExpertSinglePageScreen(
                  expert: controller.chat.user,
                  fromChat: true,
                ),
              );
            },
            child: Container(
              // height: Get.height / 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: ViewUtils.boxShadow(),
              ),
              width: Get.width / 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (controller.chat.user.avatar is String)
                      ClipRRect(
                        child: Image.network(
                          controller.chat.user.avatar!,
                          width: Get.width / 8,
                          fit: BoxFit.fill,
                          height: Get.width / 8,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    if (controller.chat.user.avatar == null)
                      Icon(
                        Ionicons.person_outline,
                        size: Get.width / 8,
                        color: ColorUtils.mainRed,
                      ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.chat.user.fullName,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.chat.user.specialities!.isNotEmpty
                              ? controller.chat.user.specialities!
                                  .map((e) => e.name)
                                  .join('٬ ')
                              : '',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      color: ColorUtils.green,
                      size: Get.width / 12,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => ExpertSinglePageScreen(
                  expert: controller.chat.user,
                  fromChat: true,
                ),
              );
            },
            child: Container(
              // height: Get.height * .15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: ViewUtils.boxShadow(),
              ),
              width: Get.width / 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (controller.chat.user.avatar is String)
                      ClipRRect(
                        child: Image.network(
                          controller.chat.user.avatar!,
                          width: Get.width / 8,
                          fit: BoxFit.fill,
                          height: Get.width / 8,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    if (controller.chat.user.avatar == null)
                      Icon(
                        Ionicons.person_outline,
                        size: Get.width / 8,
                        color: ColorUtils.mainRed,
                      ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.chat.user.fullName,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.chat.user.specialities!.isNotEmpty
                              ? controller.chat.user.specialities!
                                  .map((e) => e.name)
                                  .join('٬ ')
                              : '',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      color: ColorUtils.green,
                      size: Get.width / 12,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildBody() {
    return Padding(
      padding: ViewUtils.scaffoldPadding,
      child: GetBuilder(
          init: controller,
          builder: (context) {
            return Column(
              children: [
                ViewUtils.sizedBox(),
                buildUser(),
                ViewUtils.sizedBox(),
                Expanded(
                  child: buildList(),
                ),
                _buildTextBox(),
                ViewUtils.sizedBox(80),
              ],
            );
          }),
    );
  }

  Widget buildList() {
    return ListView.builder(
      controller: controller.scrollController,
      itemBuilder: buildMessage,
      itemCount: controller.chat.messages.length,
    );
  }

  Widget buildMessage(BuildContext context, int index) {
    MessageModel message = controller.chat.messages[index];
    bool iAmTheFuckingSender = message.sender == Globals.userStream.user?.id;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      width: Get.width,
      child: Row(
        mainAxisAlignment: iAmTheFuckingSender
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          GestureDetector(
            onLongPress: () {
              controller.unFocus();
              controller.deleteMessageAlert(message: message);
            },
            child: Container(
              decoration: BoxDecoration(
                color: iAmTheFuckingSender
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
                  crossAxisAlignment: iAmTheFuckingSender
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: Get.width / 1.5,
                      ),
                      child: Text(
                        message.title,

                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (iAmTheFuckingSender)
                          const SizedBox(
                            width: 8.0,
                          ),
                        Text(
                          message.time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11.0,
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              message.id > 0
                                  ? Icons.check
                                  : Icons.timer_outlined,
                              color: Colors.white.withOpacity(0.8),
                              size: 12.0,
                            ),
                            if (message.isRead)
                              Positioned(
                                right: 5.0,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 12.0,
                                ),
                              ),
                          ],
                        ),
                        if (!iAmTheFuckingSender)
                          const SizedBox(
                            width: 8.0,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
                  constraints: BoxConstraints(
                    maxHeight: Get.height * .15
                  ),
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
                    controller: controller.messageTextController,
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
                onTap: () => controller.sendMessage(),
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
                  constraints: BoxConstraints(
                      maxHeight: Get.height * .15
                  ),
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
                    controller: controller.messageTextController,
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
                onTap: () => controller.sendMessage(),
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
}
