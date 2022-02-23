import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/Bookmarks/bookmarks_controller.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class BookmarksScreen extends StatelessWidget {
  final BookmarksController controller = Get.put(
    BookmarksController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        key: controller.scaffoldKey,
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: buildBody(),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(),
        const Text(
          "نشان شده ها",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        ViewUtils.sizedBox(),
        buildExperts(),
      ],
    );
  }

  Widget buildExperts() {
    return Obx(
      () => Expanded(
        child: controller.isBookmarksLoaded.value == true
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.listOfBookmarks.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller: controller.bookmarksRefreshController,
                            onRefresh: () async {
                              await controller.allBookmarks();
                              controller.bookmarksRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.listOfBookmarks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: buildExpert(
                                          controller.listOfBookmarks[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : WidgetUtils.dataNotFound("خدمت");
                })
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildExpert(UserModel expert) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: Get.height / 9,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Get.to(
            () => ExpertSinglePageScreen(
              expert: expert,
              fromChat: false,
              bookmarksController: controller,
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      expert.avatar ?? '',
                      width: Get.width / 4,
                      height: Get.width / 4,
                      fit: BoxFit.cover,
                    ),
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
                    expert.fullName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  Text(
                    expert.fields!.isNotEmpty
                        ? expert.fields!.map((e) => e.name).join('٬ ')
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
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }
}
