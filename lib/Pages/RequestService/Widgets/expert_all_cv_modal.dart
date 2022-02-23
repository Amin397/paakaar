import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/FilePreview.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/Shared/image_preview_dialog.dart';
import 'package:paakaar/Widgets/Shared/video_player_dialog.dart';
import 'package:paakaar/Widgets/Shared/voice_player_dialog.dart';

class ShowAllCV extends StatelessWidget {
  ShowAllCV({Key? key, required this.listOfCvFiles, this.expert})
      : super(key: key);
  List<CustomFileModel> listOfCvFiles = [];
  UserModel? expert;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: Get.height * .5,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Ionicons.close,
                    color: ColorUtils.textColor,
                  ),
                ),
                Text(
                  'نمونه کار ها',
                  style: TextStyle(
                    color: ColorUtils.textColor,
                    fontSize: 12.0,
                  ),
                ),
                const Text(
                  'نمونه کار ها',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: AnimationLimiter(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: listOfCvFiles.length,
                    itemBuilder: buildCvFileItem,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCvFileItem(BuildContext context, int index) {
    CustomFileModel file = listOfCvFiles[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        verticalOffset: index * 25.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () => previewItem(
              expert!.cvItems![index],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: Get.width * .25,
                  height: Get.height * .08,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FilePreview(
                      file: file,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Center(
                  child: AutoSizeText(
                    file.name,
                    maxLines: 1,
                    maxFontSize: 14.0,
                    minFontSize: 10.0,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void previewItem(CustomFileModel item) {
    String cvItem = item.url!;
    print(cvItem);
    String ext = cvItem.split('.').last;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return preViewImage(item);
        break;
      case 'mp4':
      case 'mov':
      case 'mkv':
      case 'flv':
      case 'mpeg':
        return preViewVideo(item);
        break;
      case '3gp':
      case 'aa':
      case 'aac':
      case 'mp3':
      case 'waw':
      case '':
        return preViewAudio(item);
        break;
      case 'pdf':
      case 'doc':
      case 'docm':
      case 'docx':
      case 'html':
      case 'htm':
      case 'rtf':
      case 'txt':
      case 'xml':
      case 'xps':
      case 'csv':
      case 'xltx':
      case 'xlsx':
      case 'xls':
      default:
        return download(item);
        break;
    }
  }

  void preViewAudio(CustomFileModel cvItem) {
    Get.dialog(
      VoicePlayerDialog(
        file: cvItem,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void preViewImage(CustomFileModel cvItem) {
    Get.dialog(
      ImagePreviewDialog(
        file: cvItem,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void preViewVideo(CustomFileModel cvItem) {
    Get.dialog(
      VideoPlayerDialog(
        file: cvItem,
        fromDashboard: false,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void download(CustomFileModel cvItem) async {
    var dio = Dio();
    download2(dio, cvItem.url!, cvItem.name);
  }

  Future download2(Dio dio, String url, String fileName) async {
    Permission.storage.status.then(
      (value) async {
        if (!value.isGranted) {
          Permission.storage.request().then((value) {
            download2(
              dio,
              url,
              fileName,
            );
          });
        } else {
          EasyLoading.show(
            status: 'درحال دانلود فایل لطفا صبر کنید',
          );
          try {
            dio
                .get(
              url,
              onReceiveProgress: showDownloadProgress,
              //Received data with List<int>
              options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ),
            )
                .then(
              (value) async {
                Directory dir = Directory('/storage/emulated/0/Download');
                print(value.headers);
                print(dir.path);
                File file =
                    File("${dir.path}/$fileName.${url.split('.').last}");
                var raf = file.openSync(mode: FileMode.write);
                // value.data is List<int> type
                raf.writeFromSync(value.data);
                await raf.close();
                EasyLoading.dismiss();
                ViewUtils.showSuccessDialog(
                  'با موفقیت دانلود شد',
                );
              },
            );
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
