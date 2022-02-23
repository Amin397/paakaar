import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/Chat/chat_controller.dart';
import 'package:paakaar/Models/Chat/chat_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class ChatScreen extends StatelessWidget {
  final bool isDirect;
  final ChatController controller = Get.put(
    ChatController(),
  );

  ChatScreen({
    Key? key,
    this.isDirect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isChatsLoaded.isTrue
          ? buildList()
          : Center(
              child: WidgetUtils.loadingWidget(),
            ),
    );
  }

  Widget buildList() {
    return Padding(
      padding: ViewUtils.scaffoldPadding,
      child: Container(
        height: Get.height / 1.2,
        child: Column(
          children: [
            ViewUtils.sizedBox(),
            WidgetUtils.mainSearchTextField(
              controller: controller.searchController,
              onChange: (String str) {
                controller.isChatsLoaded.value = false;
                controller.listOfChats.forEach((element) {
                  element.searchShow = element.user.fullName.contains(str);
                });
                controller.isChatsLoaded.value = true;
              },
            ),
            ViewUtils.sizedBox(),
            GetBuilder(
              init: controller,
              builder: (ctx) {
                return Expanded(
                  child: FRefresh(
                    headerHeight: Get.height / 8,
                    header: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Center(
                        child: WidgetUtils.loadingWidget(),
                      ),
                    ),
                    controller: controller.refreshController,
                    onRefresh: () async {
                      controller.unFocus();
                      await controller.getChats();
                      controller.refreshController.finishRefresh();
                    },
                    child: (controller.listOfChats
                            .where((element) => element.searchShow)
                            .toList()
                            .isEmpty)
                        ? Center(
                            child: AutoSizeText(
                              'هیچ داده ای یافت نشد',
                              style: TextStyle(
                                color: ColorUtils.textColor,
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: buildChatRow,
                            separatorBuilder: buildSeparator,
                            itemCount: controller.listOfChats
                                .where((element) => element.searchShow)
                                .toList()
                                .length,
                          ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    return Divider(
      color: ColorUtils.mainRed.withOpacity(0.5),
    );
  }

  Widget buildChatRow(BuildContext context, int index) {
    ChatModel chat = controller.listOfChats
        .where((element) => element.searchShow)
        .toList()[index];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 300.0) {
          return Container(
            height: Get.height / 18,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onLongPress: () {
                  controller.deleteMessageAlert(user: chat);
                },
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  controller.unFocus();
                  Get.toNamed(
                    RoutingUtils.chatSingle.name,
                    arguments: {'chat': chat},
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: Get.width / 8,
                      height: Get.width / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          chat.user.avatar ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          chat.user.fullName,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: ColorUtils.black,
                          ),
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              chat.messages.last.title,
                              maxLines: 1,
                              maxFontSize: 14.0,
                              minFontSize: 10.0,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: ColorUtils.textColor,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: ColorUtils.mainRed,
                                  size: 12.0,
                                ),
                                if (chat.messages.last.isRead)
                                  const Positioned(
                                    right: 5.0,
                                    child: Icon(
                                      Icons.check,
                                      size: 12.0,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      color: ColorUtils.green.shade700,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: Get.height / 17,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  controller.unFocus();
                  Get.toNamed(
                    RoutingUtils.chatSingle.name,
                    arguments: {'chat': chat},
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: Get.width / 8,
                      height: Get.width / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          chat.user.avatar ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          chat.user.fullName,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: ColorUtils.black,
                          ),
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              chat.messages.last.title,
                              maxLines: 1,
                              maxFontSize: 14.0,
                              minFontSize: 10.0,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: ColorUtils.textColor,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: ColorUtils.mainRed,
                                  size: 12.0,
                                ),
                                if (chat.messages.last.isRead)
                                  const Positioned(
                                    right: 5.0,
                                    child: Icon(
                                      Icons.check,
                                      size: 12.0,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      color: ColorUtils.green.shade700,
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
}
