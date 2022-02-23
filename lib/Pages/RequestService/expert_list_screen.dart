import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Controllers/Services/expert_list_controller.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class ExpertListScreen extends StatelessWidget {
  final ExpertListController controller = Get.put(
    ExpertListController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: this.controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        key: this.controller.scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorUtils.mainRed,
          elevation: 4.0,
          highlightElevation: 4.0,
          focusElevation: 4.0,
          hoverElevation: 4.0,
          onPressed: () => this.controller.getCityAndState(),
          child: Icon(
            Icons.location_on_outlined,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: this.buildBody(),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(25),
        WidgetUtils.mainSearchTextField(),
        ViewUtils.sizedBox(),
        this.buildFilters(),
        ViewUtils.sizedBox(25),
        this.buildExperts(),
      ],
    );
  }

  Widget buildFilters() {
    return Container(
      height: Get.height / 19,
      child: Obx(
        () => this.controller.isOptionsLoaded.isTrue
            ? GetBuilder<ExpertListController>(
                builder: (context) {
                  return AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: this.controller.listOfOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: this.buildOptionItem(
                                this.controller.listOfOptions[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildOptionItem(OptionModel option) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => this.controller.getOptionValues(option),
          onLongPress: () {
            option.values.forEach((element) {
              element.isSelected.value = false;
            });
            this.controller.update();
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (option.isSelected) ...[
                  Icon(
                    Icons.close,
                    color: ColorUtils.mainRed,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                ],
                Text(
                  option.name,
                ),
                if (!option.isSelected) ...[
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ColorUtils.green,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(),
      ),
    );
  }

  Widget buildExperts() {
    return Obx(
      () => Expanded(
        child: this.controller.isIndividualsLoaded.isTrue
            ? AnimationLimiter(
                child: ListView.builder(
                    itemCount: this.controller.listOfExperts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: this.buildExpert(
                              this.controller.listOfExperts[index],
                            ),
                          ),
                        ),
                      );
                    }),
              )
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
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
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
              SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    expert.fullName,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  Text(
                    expert.fields!.length > 0
                        ? expert.fields!.map((e) => e.name).join('٬ ')
                        : '',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.green,
              ),
            ],
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }
}
