import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/UserDashboardController/user_dashboard_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/membership_model.dart';
import 'package:paakaar/Pages/MembershipInfoScreen/membership_info_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class UserDashboardScreen extends StatelessWidget {
  final bool isDirect;

  final UserDashboardController controller = Get.put(
    UserDashboardController(),
  );

  UserDashboardScreen({
    Key? key,
    this.isDirect = true,
  }) : super(key: key);

  MembershipModel get membership => Globals.userStream.user!.role!;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: controller.scaffoldKey,
        appBar: isDirect
            ? WidgetUtils.appBar(
                innerPage: true,
                key: controller.scaffoldKey,
              )
            : null,
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildUser() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 300.0) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                RoutingUtils.completeProfile.name,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                NeumorphicContainer(
                  height: Get.height / 10,
                  decoration: MyNeumorphicDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  curveType: CurveType.concave,
                  width: Get.width / 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (Globals.userStream.user?.avatar is String)
                          ClipRRect(
                            child: Image.network(
                              Globals.userStream.user!.avatar!,
                              width: Get.width / 8,
                              fit: BoxFit.fill,
                              height: Get.width / 8,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        if (Globals.userStream.user?.avatar == null)
                          Icon(
                            Ionicons.person_outline,
                            size: Get.width / 8,
                            color: ColorUtils.mainRed,
                          ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Globals.userStream.user!.fullName,
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          color: ColorUtils.green,
                          size: Get.width / 12,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -5,
                  child: GestureDetector(
                    onTap: () => Get.dialog(
                      MembershipInfoScreen(
                        membership: membership,
                      ),
                      barrierColor: ColorUtils.black.withOpacity(0.5),
                    ),
                    child: Container(
                      height: Get.height / 24,
                      width: Get.height / 24,
                      decoration: BoxDecoration(
                        color: ColorUtils.orange.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorUtils.orange,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user!.role!.membershipName,
                          maxLines: 1,
                          minFontSize: 1.0,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                RoutingUtils.completeProfile.name,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                NeumorphicContainer(
                  height: Get.height * .1,
                  decoration: MyNeumorphicDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  curveType: CurveType.concave,
                  width: Get.width,
                  child: Container(
                    child: Row(
                      children: [
                        if (Globals.userStream.user?.avatar is String)
                          ClipRRect(
                            child: Image.network(
                              Globals.userStream.user!.avatar!,
                              width: Get.width * .1,
                              fit: BoxFit.fill,
                              height: Get.width * .1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        if (Globals.userStream.user?.avatar == null)
                          Icon(
                            Ionicons.person_outline,
                            size: Get.width * .1,
                            color: ColorUtils.mainRed,
                          ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          child: AutoSizeText(
                            Globals.userStream.user!.fullName,
                            maxFontSize: 18.0,
                            maxLines: 1,
                            minFontSize: 14.0,
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_right,
                          color: ColorUtils.green,
                          size: Get.width / 12,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -5,
                  child: GestureDetector(
                    onTap: () => Get.dialog(
                      MembershipInfoScreen(
                        membership: membership,
                      ),
                      barrierColor: ColorUtils.black.withOpacity(0.5),
                    ),
                    child: Container(
                      height: Get.height / 24,
                      width: Get.height / 24,
                      decoration: BoxDecoration(
                        color: ColorUtils.orange.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorUtils.orange,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user!.role!.membershipName,
                          maxLines: 1,
                          minFontSize: 1.0,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildBody() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ViewUtils.sizedBox(25),
            buildUser(),
            ViewUtils.sizedBox(),
            Container(
              width: Get.width,
              height: Get.height / 16,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اشتراک ${Globals.userStream.user!.role!.membershipName}",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'تا ${Globals.userStream.user!.membershipExpire}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ColorUtils.mainRed,
                // boxShadow: ViewUtils.boxShadow(
                //   spreadRadius: 2.0,
                //   blurRadius: 12.0,
                // ),
              ),
            ),
            ViewUtils.sizedBox(),
            Row(
              children: [
                Expanded(
                  child: buildSubmittedAds(),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: buildSubmittedCallouts(),
                ),
              ],
            ),
            ViewUtils.sizedBox(),
            buildMyProposals(),
            ViewUtils.sizedBox(),
            buildMyScores(),
            ViewUtils.sizedBox(),
            buildIcons(),
          ],
        ),
      ),
    );
  }

  Widget buildSubmittedAds() {
    return StreamBuilder(
      stream: Globals.userStream.getStream,
      builder: (BuildContext context, i) {
        return buildMainIcon(
          onTap: () {
            Get.toNamed(
              RoutingUtils.myAds.name,
            );
          },
          icon: Image(
            image: const AssetImage(
              ImageUtils.selectIconPath,
            ),
            height: Get.height / 16,
          ),
          text: "آگهی های من",
          badge: Globals.userStream.user?.adCount ?? 0,
        );
      },
    );
  }

  Widget buildSubmittedCallouts() {
    return StreamBuilder(
      stream: Globals.userStream.getStream,
      builder: (BuildContext context, i) {
        return buildMainIcon(
          icon: Image(
            image: const AssetImage(
              ImageUtils.campaignIconPath,
            ),
            height: Get.height * .05,
          ),
          onTap: () {
            Get.toNamed(
              RoutingUtils.myCallOuts.name,
            );

            // print(Globals.userStream.user?.callOutCount);
          },
          text: "فراخوان های ارسالی من",
          badge: Globals.userStream.user?.callOutCount ?? 0,
        );
      },
    );
  }

  Widget buildMyProposals() {
    return StreamBuilder(
      stream: Globals.userStream.getStream,
      builder: (BuildContext context, i) {
        return GestureDetector(
          onTap: () => Get.toNamed(
            RoutingUtils.myProposals.name,
          ),
          child: Container(
            width: Get.width,
            height: Get.height / 18,
            decoration: BoxDecoration(
              boxShadow: ViewUtils.boxShadow(),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoSizeText(
                    "پیشنهاد های من (به فراخوان دیگران)",
                    maxLines: 1,
                    maxFontSize: 16.0,
                    minFontSize: 10.0,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorUtils.mainRed,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: StreamBuilder(
                          stream: Globals.userStream.getStream,
                          builder: (BuildContext context, i) {
                            return Text(
                              "${Globals.userStream.user?.sentProposalCount.toString()} عدد",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMyScores() {
    return StreamBuilder(
      stream: Globals.userStream.getStream,
      builder: (BuildContext context, i) {
        return GestureDetector(
          onTap: () => Get.toNamed(
            RoutingUtils.userScore.name,
          ),
          child: Container(
            width: Get.width,
            height: Get.height * .1,
            decoration: BoxDecoration(
              boxShadow: ViewUtils.boxShadow(),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "امتیاز های من",
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorUtils.mainRed,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        "${Globals.userStream.user?.score.toString()} امتیاز",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMainIcon({
    Widget? icon,
    required String text,
    bool isEnabled = true,
    Null Function()? onTap,
    required int badge,
  }) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: Get.height / 6,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (icon is Widget) icon,
                    ViewUtils.sizedBox(75),
                    Text(
                      text,
                      style: TextStyle(
                        color: isEnabled
                            ? ColorUtils.textColor
                            : ColorUtils.inActiveTextColor,
                      ),
                    ),
                    ViewUtils.sizedBox(150),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorUtils.mainRed,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          "${badge.toString()} عدد",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: ViewUtils.boxShadow(
                  spreadRadius: 2.0,
                  blurRadius: 12.0,
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: Get.height * .16,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (icon is Widget) icon,
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: isEnabled
                            ? ColorUtils.textColor
                            : ColorUtils.inActiveTextColor,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorUtils.mainRed,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child: Text(
                          "${badge.toString()} عدد",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: ViewUtils.boxShadow(
                  spreadRadius: 2.0,
                  blurRadius: 12.0,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildIcons() {
    return Container(
      width: Get.width,
      height: Get.height * .95,
      child: Column(
        children: [
          ViewUtils.sizedBox(),
          Center(
            child: Column(
              children: [
                Text(
                  "اشتراک ${membership.membershipName}",
                  style: TextStyle(
                    color: ColorUtils.mainRed.shade900,
                    fontSize: 17.0,
                  ),
                ),
                ViewUtils.sizedBox(),
                SvgPicture.asset(
                  ImageUtils.medalIcon,
                  width: Get.width / 12,
                ),
              ],
            ),
          ),
          ViewUtils.sizedBox(),
          Expanded(
            child: Column(
              children: [
                // ViewUtils.sizedBox(25),
                buildInfoRow(
                  first: "زمان اشتراک",
                  second: membership.membershipTime!,
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "قیمت اشتراک",
                  second: ViewUtils.moneyFormat(
                        membership.membershipPrice!.toDouble(),
                      ) +
                      ' تومان',
                ),
                ViewUtils.sizedBox(20),
                buildInfoRow(
                  first: "تعداد آگهی های رایگان",
                  second: membership.freeAdCount.toString() + ' عدد',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "زمان آگهی های رایگان",
                  second: membership.freeAdTime.toString() + ' روز',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "تعداد آگهی های غیر رایگان",
                  second: membership.priceAdCount.toString() + ' عدد',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "هزینه آگهی های غیر رایگان",
                  second:
                      ViewUtils.moneyFormat(membership.adPrice!.toDouble()) +
                          ' تومان',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "زمان آگهی های غیر رایگان",
                  second: membership.priceCallTime.toString() + ' روز',
                ),
                ViewUtils.sizedBox(20),
                buildInfoRow(
                  first: "تعداد فراخوان های رایگان",
                  second: membership.freeCallCount.toString() + ' عدد',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "زمان فراخوان های رایگان",
                  second: membership.freeCallTime.toString() + ' روز',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "تعداد فراخوان های غیر رایگان",
                  second: membership.priceCallCount.toString() + ' عدد',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "هزینه فراخوان های غیر رایگان",
                  second:
                      ViewUtils.moneyFormat(membership.callPrice!.toDouble()) +
                          ' تومان',
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "زمان فراخوان های غیر رایگان",
                  second: membership.priceCallTime.toString() + ' روز',
                ),
                ViewUtils.sizedBox(20),
                buildInfoRow(
                  first: "قابلیت دیدن آگهی ها",
                  second: membership.viewAds! ? "دارد" : "ندارد",
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "قابلیت دیدن فراخوان ها",
                  second: membership.viewCalls! ? "دارد" : "ندارد",
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "قابلیت دیدن اسلایدر",
                  second: membership.viewUpSliders! ? "دارد" : "ندارد",
                ),
                ViewUtils.sizedBox(60),
                buildInfoRow(
                  first: "قابلیت دیدن ویدیو ها",
                  second: membership.viewTvs! ? "دارد" : "ندارد",
                ),
                ViewUtils.sizedBox(25),
                // WidgetUtils.button(
                //   text: "بازگشت",
                //   onTap: () => Get.back(),
                // ),
                // ViewUtils.sizedBox(12.5),
              ],
            ),
          ),
          // ViewUtils.sizedBox(35),
        ],
      ),
    );
  }

  Widget buildInfoRow({required String first, required String second}) {
    return Row(
      children: [
        Text(
          first,
          style: TextStyle(
            color: ColorUtils.textColor,
            fontSize: 14.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: ColorUtils.mainRed.shade200,
              thickness: 0.2,
            ),
          ),
        ),
        Text(
          second,
          style: TextStyle(
            color: ColorUtils.mainRed.shade900,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
