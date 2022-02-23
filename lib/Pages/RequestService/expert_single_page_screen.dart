import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:paakaar/Controllers/Bookmarks/bookmarks_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/social_media_model.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Chat/chat_model.dart';
import 'package:paakaar/Models/Comments/CommentModel.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Pages/Profile/Widgets/show_single_comments.dart';
import 'package:paakaar/Plugins/FilePreview.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/image_preview_dialog.dart';
import 'package:paakaar/Widgets/Shared/video_player_dialog.dart';
import 'package:paakaar/Widgets/Shared/voice_player_dialog.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';
import 'package:paakaar/Widgets/image_preview_profie_dialog.dart';
import 'package:paakaar/Widgets/rate_user_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Widgets/expert_all_cv_modal.dart';

class ExpertSinglePageScreen extends StatefulWidget {
  UserModel? expert;
  bool? fromChat;
  final String? expertId;
  final BookmarksController? bookmarksController;

  ExpertSinglePageScreen({
    Key? key,
    this.expert,
    this.fromChat,
    this.expertId,
    this.bookmarksController,
  }) : super(key: key);

  @override
  State<ExpertSinglePageScreen> createState() => _ExpertSinglePageScreenState();
}

class _ExpertSinglePageScreenState extends State<ExpertSinglePageScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool commentSwitch = false.obs;

  List<CustomFileModel> listOfCvFiles = [];

  final ProjectRequestUtils _projectRequestUtils = ProjectRequestUtils();

  @override
  void initState() {
    if (widget.expertId is String) {
      getIndividual();
    } else {
      getCvFiles();
    }
    super.initState();
  }

  getIndividual() async {
    ApiResult result =
        await _projectRequestUtils.getIndividualData(widget.expertId!);
    if (result.isDone) {
      setState(() {
        widget.expert = UserModel.fromJson(
          result.data,
        );
      });
      getCvFiles();
    }
  }

  void getCvFiles() {
    widget.expert!.cvItems?.forEach((element) {
      listOfCvFiles.add(
        element,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: scaffoldKey,
        ),
        key: scaffoldKey,
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: Center(
            child: (widget.expert is UserModel)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        ViewUtils.sizedBox(),
                        buildAvatar(),
                        ViewUtils.sizedBox(),
                        Text(
                          widget.expert!.fullName,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: ColorUtils.black,
                          ),
                        ),
                        ViewUtils.sizedBox(),
                        Text(
                          widget.expert!.specialities!
                              .map((e) => e.name)
                              .join(', '),
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                        ViewUtils.sizedBox(),
                        LayoutBuilder(
                          builder:
                              (BuildContext context, BoxConstraints raints) {
                            if (raints.maxWidth > 480.0) {
                              return RatingBar.builder(
                                onRatingUpdate: (double rating) {},
                                initialRating: widget.expert!.rate ?? 0.0,
                                minRating: 1,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                                textDirection: TextDirection.ltr,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                glowColor: Colors.white,
                                unratedColor:
                                    ColorUtils.textColor.withOpacity(0.2),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                              );
                            } else {
                              return RatingBar.builder(
                                onRatingUpdate: (double rating) {},
                                initialRating: widget.expert!.rate ?? 0.0,
                                minRating: 1,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                                textDirection: TextDirection.ltr,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                glowColor: Colors.white,
                                unratedColor:
                                    ColorUtils.textColor.withOpacity(0.2),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.height * .05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'امتیاز ${widget.expert!.fullName}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                ' از ${widget.expert!.rateCount} نفر : ',
                                style: TextStyle(
                                  color: ColorUtils.myRed,
                                ),
                              ),
                              Text(widget.expert!.rate!.toStringAsFixed(1)),
                            ],
                          ),
                        ),
                        ViewUtils.sizedBox(),
                        buildBio(),
                        ViewUtils.sizedBox(),
                        Divider(
                          color: ColorUtils.mainRed,
                        ),
                        ViewUtils.sizedBox(),
                        buildCv(),
                        ViewUtils.sizedBox(),
                        Divider(
                          color: ColorUtils.mainRed,
                        ),
                        ViewUtils.sizedBox(),
                        buildSamples(),
                        ViewUtils.sizedBox(),
                        buildSocialMedias(),
                        ViewUtils.sizedBox(),
                        if (widget.expert!.comments.isNotEmpty) ...[
                          buildComments(),
                          ViewUtils.sizedBox(),
                        ],
                        (!widget.fromChat!)
                            ? Divider(
                                color: ColorUtils.mainRed,
                              )
                            : Container(),
                        ViewUtils.sizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.expert!.isMobileShown) ...[
                              GestureDetector(
                                onTap: () {
                                  launch("tel:${widget.expert!.mobile}");
                                },
                                child: Container(
                                  height: Get.height / 21,
                                  width: Get.width / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: ViewUtils.boxShadow(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        color: ColorUtils.green,
                                      ),
                                      Text(
                                        "تماس تلفنی",
                                        style: TextStyle(
                                          color: ColorUtils.textColor,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                            ],
                            (!widget.fromChat!)
                                ? GestureDetector(
                                    onTap: () {
                                      startChat();
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.message_outlined,
                                            color: ColorUtils.mainRed,
                                          ),
                                          Text(
                                            "ارسال پیام",
                                            style: TextStyle(
                                              color: ColorUtils.textColor,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: Get.height / 21,
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: ViewUtils.boxShadow(),
                                      ),
                                    ),
                                  )
                                : Container(),
                            if (!widget.expert!.comments.any((element) =>
                                    element.raterId ==
                                    Globals.userStream.user?.id) &&
                                Globals.userStream.user?.id !=
                                    widget.expert!.id) ...[
                              const SizedBox(
                                width: 16.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  addComment();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.add_comment,
                                        color: ColorUtils.orange,
                                      ),
                                      Text(
                                        "ثبت نظر",
                                        style: TextStyle(
                                          color: ColorUtils.textColor,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: Get.height / 21,
                                  width: Get.width / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: ViewUtils.boxShadow(),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                        ViewUtils.sizedBox(12.5),
                      ],
                    ),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget buildBio() {
    return SizedBox(
      width: Get.width,
      child: ExpandableNotifier(
        child: ExpandablePanel(
          collapsed: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'بیوگرافی',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  ExpandableButton(
                    theme: ExpandableThemeData(
                      inkWellBorderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
            ],
          ),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'بیوگرافی',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  ExpandableButton(
                    theme: ExpandableThemeData(
                      inkWellBorderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ],
              ),
              ViewUtils.sizedBox(),
              Text(
                widget.expert!.bio ?? '',
                style: TextStyle(
                  fontSize: 14.0,
                  color: ColorUtils.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCv() {
    return Container(
      width: Get.width / 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'رزومه و سابقه کاری',
                style: TextStyle(
                  fontSize: 16.0,
                  color: ColorUtils.black,
                ),
              ),
            ],
          ),
          ViewUtils.sizedBox(),
          Text(
            widget.expert!.individualCv ?? '',
            style: TextStyle(
              fontSize: 14.0,
              color: ColorUtils.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSamples() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'نمونه کار ها',
              style: TextStyle(
                fontSize: 16.0,
                color: ColorUtils.black,
              ),
            ),
          ],
        ),
        ViewUtils.sizedBox(),
        SizedBox(
          height: Get.height * .15,
          child: listOfCvFiles.isNotEmpty
              ? AnimationLimiter(
                  child: ListView.builder(
                    itemCount: (listOfCvFiles.length > 4)
                        ? listOfCvFiles.take(4).length
                        : listOfCvFiles.length,
                    itemBuilder: buildCvFileItem,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                )
              : const Center(
                  child: Text(
                    "هیچ نمونه کاری ثبت نشده است",
                  ),
                ),
        ),
        // ViewUtils.sizedBox(),
        (listOfCvFiles.length > 4)
            ? TextButton(
                child: Text(
                  'مشاهده همه نمونه کار ها',
                  style: TextStyle(
                    color: ColorUtils.blue,
                    fontSize: 12.0,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    backgroundColor: Colors.transparent,
                    // barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return ShowAllCV(
                        listOfCvFiles: listOfCvFiles,
                        expert: widget.expert,
                      );
                    },
                  );
                },
              )
            : Container()
      ],
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
              widget.expert!.cvItems![index],
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

  void startChat() async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.startChat(
      targetId: widget.expert!.id!,
    );
    EasyLoading.dismiss();

    if (result.isDone) {
      print(result.data);
      ChatModel chat = ChatModel.fromJson(result.data);
      Get.toNamed(
        RoutingUtils.chatSingle.name,
        arguments: {
          'chat': chat,
        },
      );
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
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

  void download(CustomFileModel cvItem) async {
    print('amin');

    var dio = Dio();
    download2(dio, cvItem.url!, cvItem.name);

    // final amin = await FlutterDownloader.enqueue(
    //   url: cvItem.url!.replaceAll('http', 'https'),
    //   fileName: cvItem.name,
    //   savedDir: '/storage/emulated/0/Download/',
    //   showNotification: true, // show download progress in status bar (for Android)
    //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    // );
  }

  Future download2(Dio dio, String url, String fileName) async {
    Permission.storage.status.then((value) async {
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
                }),
          )
              .then((value) async {
            Directory dir = Directory('/storage/emulated/0/Download');
            print(value.headers);
            print(dir.path);
            File file = File("${dir.path}/$fileName.${url.split('.').last}");
            var raf = file.openSync(mode: FileMode.write);
            // value.data is List<int> type
            raf.writeFromSync(value.data);
            await raf.close();
            EasyLoading.dismiss();
            ViewUtils.showSuccessDialog(
              'با موفقیت دانلود شد',
            );
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
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

  void preViewProfileImage(String path) {
    Get.dialog(
      ImagePreviewProfileDialog(
        path: path,
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

  Widget buildSocialMedias() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return Container(
            height: Get.height / 10 +
                (((widget.expert!.socialMedia?.length ?? 0)) *
                        (Get.height / 18) +
                    8),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorUtils.mainRed,
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 37,
                        child: const Center(
                          child: Text(
                            "راه های ارتباطی",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Divider(
                      color: ColorUtils.mainRed,
                      thickness: 0.1,
                    ),
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expert!.socialMedia?.length,
                        itemBuilder: buildSocialMedia,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: Get.height * .13 +
                (((widget.expert!.socialMedia?.length ?? 0)) *
                        (Get.height / 18) +
                    8),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorUtils.mainRed,
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 37,
                        child: const Center(
                          child: Text(
                            "راه های ارتباطی",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Divider(
                      color: ColorUtils.mainRed,
                      thickness: 0.1,
                    ),
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expert!.socialMedia?.length,
                        itemBuilder: buildSocialMedia,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildComments() {
    return Obx(
      () => Container(
        width: Get.width,
        // height: (commentSwitch.value)
        //     ? (widget.expert.comments.length * Get.height * .32)
        //     : Get.height * .32,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              height: (commentSwitch.value)
                  ? (widget.expert!.comments.length * Get.height * .14)
                  : Get.height * .2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorUtils.mainRed,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 37,
                          child: const Center(
                            child: Text(
                              "نظرات",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (!widget.expert!.comments.any((element) =>
                                element.raterId ==
                                Globals.userStream.user?.id) &&
                            Globals.userStream.user?.id != widget.expert!.id)
                          GestureDetector(
                            onTap: () async {
                              addComment();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: ViewUtils.boxShadow(
                                  blurRadius: 12.0,
                                  spreadRadius: 2.0,
                                ),
                                shape: BoxShape.circle,
                              ),
                              height: 37,
                              width: 37,
                              child: Center(
                                child: Icon(
                                  Ionicons.add,
                                  color: ColorUtils.mainRed,
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Divider(
                        color: ColorUtils.mainRed,
                        thickness: 0.1,
                      ),
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.expert!.comments.length,
                          itemBuilder: buildComment,
                          separatorBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(
                              color: ColorUtils.mainRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => ShowComments(
                    comments: widget.expert!.comments,
                  ),
                );
              },
              child: Text(
                (!commentSwitch.value) ? 'مشاهده همه' : 'نمایش کمتر',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSocialMedia(BuildContext context, int index) {
    SocialMediaModel socialMedia = widget.expert!.socialMedia![index];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return GestureDetector(
            onTap: () async {
              // launch(socialMedia.prefix! + socialMedia.address!);
              // launch(socialMedia.address!);
              launch(socialMedia.prefix! + socialMedia.address!);
              // controller.unFocus();
              //
              // print(socialMedia.prefix! + socialMedia.address!);
              // controller.setAddressForSocialMedia(socialMedia);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: Get.height / 18,
              width: Get.width,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: Get.width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          socialMedia.icon is String ? socialMedia.icon : '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          socialMedia.isAddressSet
                              ? socialMedia.address!
                              : socialMedia.name,
                          maxFontSize: 16.0,
                          minFontSize: 12.0,
                          maxLines: 2,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: socialMedia.isAddressSet
                            ? ColorUtils.green.shade600
                            : ColorUtils.mainRed.shade800,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.link_outlined,
                      size: 15.0,
                      color: socialMedia.isAddressSet
                          ? ColorUtils.green.shade800
                          : ColorUtils.mainRed.shade200,
                    ),
                  ),
                  // SizedBox(
                  //   width: 8.0,
                  // ),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () async {
              launch(socialMedia.prefix! + socialMedia.address!);
              // controller.unFocus();
              // print(socialMedia.prefix);
              //
              // controller.setAddressForSocialMedia(socialMedia);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: Get.height * .07,
              width: Get.width,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: Get.width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          socialMedia.icon is String ? socialMedia.icon : '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          socialMedia.isAddressSet
                              ? socialMedia.address!
                              : socialMedia.name,
                          maxFontSize: 16.0,
                          minFontSize: 12.0,
                          maxLines: 2,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: socialMedia.isAddressSet
                            ? ColorUtils.green.shade600
                            : ColorUtils.mainRed.shade800,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.link_outlined,
                      size: 15.0,
                      color: socialMedia.isAddressSet
                          ? ColorUtils.green.shade800
                          : ColorUtils.mainRed.shade200,
                    ),
                  ),
                  // SizedBox(
                  //   width: 8.0,
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildComment(BuildContext context, int index) {
    CommentModel comment = widget.expert!.comments[index];
    return GestureDetector(
      onTap: () async {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  comment.raterName,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
                RatingBar.builder(
                  onRatingUpdate: (double rating) {},
                  initialRating: comment.score,
                  minRating: 1,
                  itemSize: 17.0,
                  direction: Axis.horizontal,
                  textDirection: TextDirection.ltr,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  glowColor: Colors.white,
                  unratedColor: ColorUtils.textColor.withOpacity(0.2),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            ViewUtils.sizedBox(150),
            Row(
              children: [
                Text(
                  comment.datetime,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: ColorUtils.textColor,
                  ),
                ),
              ],
            ),
            ViewUtils.sizedBox(150),
            Container(
              width: Get.width / 1.2,
              child: Text(
                comment.comment,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 12.0,
                  height: 1.5,
                  color: ColorUtils.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return Stack(
            children: [
              GestureDetector(
                onTap: (){
                  if(widget.expert!.avatar != null){
                    print('object');
                    preViewProfileImage(widget.expert!.avatar!);
                    print(widget.expert?.avatar!);
                  }else{
                    print(widget.expert?.avatar!);
                  }
                },
                child: Container(
                  width: Get.width / 2,
                  height: Get.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                    boxShadow: ViewUtils.boxShadow(
                      spreadRadius: 12.0,
                      blurRadius: 12.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      widget.expert!.avatar ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15.0,
                top: 10.0,
                child: Container(
                  width: Get.width / 12,
                  height: Get.width / 11,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: ViewUtils.boxShadow(
                      spreadRadius: 12.0,
                      blurRadius: 12.0,
                    ),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Globals.userStream
                          .bookmark(
                        widget.expert!.id ?? 0,
                      )
                          .then((value) {
                          widget.bookmarksController?.allBookmarks();
                        setState(() {});
                      }),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Icon(
                        Globals.userStream.user!
                                .isBookmarked(widget.expert!.id ?? 0)
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: ColorUtils.mainRed,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              GestureDetector(
                onTap: (){
                  if(widget.expert!.avatar != null){
                    print('object');
                    preViewProfileImage(widget.expert!.avatar!);
                    print(widget.expert?.avatar!);
                  }else{
                    print(widget.expert?.avatar!);
                  }
                },
                child: Container(
                  width: Get.width * .35,
                  height: Get.width * .35,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                    boxShadow: ViewUtils.boxShadow(
                      spreadRadius: 12.0,
                      blurRadius: 12.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      widget.expert!.avatar ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                top: 10.0,
                child: Container(
                  width: Get.width / 12,
                  height: Get.width / 11,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: ViewUtils.boxShadow(
                      spreadRadius: 12.0,
                      blurRadius: 12.0,
                    ),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Globals.userStream
                          .bookmark(
                        widget.expert!.id ?? 0,
                      )
                          .then((value) {
                          widget.bookmarksController?.allBookmarks();
                        setState(() {});
                      }),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Icon(
                        Globals.userStream.user!
                                .isBookmarked(widget.expert!.id ?? 0)
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: ColorUtils.mainRed,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void saveComment(Map<String, dynamic> map) async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.saveComment(
      rate: map['rate'],
      comment: map['comment'],
      targetId: widget.expert!.id!,
    );
    EasyLoading.dismiss();

    if (result.isDone) {
      widget.expert!.comments.add(
        CommentModel.fromJson(
          result.data['comment'],
        ),
      );
      setState(() {});
      ViewUtils.showSuccessDialog(
        result.data['message'].toString(),
      );
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  void addComment() async {
    Map<String, dynamic>? data = await Get.dialog(
      RateUserDialog(
        user: widget.expert!,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
    // print(data!['rate']);
    saveComment(data!);
  }
}
