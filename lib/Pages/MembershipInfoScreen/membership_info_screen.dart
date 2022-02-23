import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Models/Auth/membership_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class MembershipInfoScreen extends StatelessWidget {
  final MembershipModel membership;

  MembershipInfoScreen({
    Key? key,
    required this.membership,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          height: Get.height / 1.2,
          width: Get.width / 1.05,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Ionicons.close,
                    color: ColorUtils.black,
                  ),
                ),
              ),
            ],
          ),
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
                  width: Get.width / 8,
                ),
              ],
            ),
          ),
          ViewUtils.sizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: ViewUtils.scaffoldPadding,
                child: Column(
                  children: [
                    ViewUtils.sizedBox(25),
                    buildInfoRow(
                      first: "زمان اشتراک",
                      second: membership.membershipTime!,
                    ),
                    ViewUtils.sizedBox(50),
                    buildInfoRow(
                      first: "قیمت اشتراک",
                      second: ViewUtils.moneyFormat(
                            membership.membershipPrice!.toDouble(),
                          ) +
                          ' تومان',
                    ),
                    ViewUtils.sizedBox(12.5),
                    buildInfoRow(
                      first: "تعداد آگهی های رایگان",
                      second: membership.freeAdCount.toString() + ' عدد',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "زمان آگهی های رایگان",
                      second: membership.freeAdTime.toString() + ' روز',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "تعداد آگهی های غیر رایگان",
                      second: membership.priceAdCount.toString() + ' عدد',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "هزینه آگهی های غیر رایگان",
                      second: ViewUtils.moneyFormat(
                              membership.adPrice!.toDouble()) +
                          ' تومان',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "زمان آگهی های غیر رایگان",
                      second: membership.priceCallTime.toString() + ' روز',
                    ),
                    ViewUtils.sizedBox(12.5),
                    buildInfoRow(
                      first: "تعداد فراخوان های رایگان",
                      second: membership.freeCallCount.toString() + ' عدد',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "زمان فراخوان های رایگان",
                      second: membership.freeCallTime.toString() + ' روز',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "تعداد فراخوان های غیر رایگان",
                      second: membership.priceCallCount.toString() + ' عدد',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "هزینه فراخوان های غیر رایگان",
                      second: ViewUtils.moneyFormat(
                              membership.callPrice!.toDouble()) +
                          ' تومان',
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "زمان فراخوان های غیر رایگان",
                      second: membership.priceCallTime.toString() + ' روز',
                    ),
                    ViewUtils.sizedBox(12.5),
                    buildInfoRow(
                      first: "قابلیت دیدن آگهی ها",
                      second: membership.viewAds! ? "دارد" : "ندارد",
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "قابلیت دیدن فراخوان ها",
                      second: membership.viewCalls! ? "دارد" : "ندارد",
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "قابلیت دیدن اسلایدر",
                      second: membership.viewUpSliders! ? "دارد" : "ندارد",
                    ),
                    ViewUtils.sizedBox(35),
                    buildInfoRow(
                      first: "قابلیت دیدن ویدیو ها",
                      second: membership.viewTvs! ? "دارد" : "ندارد",
                    ),
                    ViewUtils.sizedBox(25),
                    WidgetUtils.button(
                      text: "بازگشت",
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ViewUtils.sizedBox(35),
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
