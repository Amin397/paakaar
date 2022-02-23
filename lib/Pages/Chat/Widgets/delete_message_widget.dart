import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Controllers/Chat/chat_single_controller.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Chat/chat_model.dart';
import 'package:paakaar/Models/Chat/messages_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';


class DeleteMessage extends StatelessWidget {
  const DeleteMessage({Key? key , this.controller , this.messageId , this.chat}) : super(key: key);
  final dynamic controller;
  final MessageModel? messageId;
  final ChatModel? chat;


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
              (chat is ChatModel)?'از حذف چت ${chat!.user.lastName} مطمئنید؟':'از حذف پیام مطمئنید؟',
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
            height: Get.height * .05,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      if(chat is ChatModel){
                        controller!.deleteChat(userId: chat);
                      }else{
                        controller!.deleteMessage(message: messageId!);
                      }
                    },
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.width * .06,
                        vertical: Get.height * .005,
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
                          'حذف',
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
