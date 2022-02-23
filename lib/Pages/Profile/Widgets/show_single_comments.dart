import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Models/Comments/CommentModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class ShowComments extends StatelessWidget {
  ShowComments({Key? key, required this.comments}) : super(key: key);
  List<CommentModel> comments = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: scaffoldKey,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * .035,
            vertical: Get.height * .01,
          ),
          height: Get.height,
          width: Get.width,
          child: AnimationLimiter(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: buildComment,
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  color: ColorUtils.mainRed,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildComment(BuildContext context, int index) {
    CommentModel comment = comments[index];
    return GestureDetector(
      onTap: () async {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  comment.raterName,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
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
                style: TextStyle(
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
}
