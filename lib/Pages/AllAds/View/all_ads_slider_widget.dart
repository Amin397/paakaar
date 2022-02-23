// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
// import 'package:paakaar/Globals/globals.dart';
// import 'package:paakaar/Models/Calls/ad_model.dart';
// import 'package:paakaar/Models/MainPage/main_ads_model.dart';
// import 'package:paakaar/Pages/Ads/ad_info_screen.dart';
// import 'package:paakaar/Pages/AllAds/Controller/all_ads_controller.dart';
// import 'package:paakaar/Pages/MainPage/Widgets/call_outs_widget.dart';
// import 'package:paakaar/Plugins/get/get.dart';
// import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
// import 'package:paakaar/Utils/color_utils.dart';
// import 'package:paakaar/Utils/routing_utils.dart';
// import 'package:paakaar/Utils/widget_utils.dart';
//
// class BuildAllAdsSliderWidget extends StatelessWidget {
//   BuildAllAdsSliderWidget({Key? key, this.allAdsController})
//       : super(key: key);
//
//   final AllAdsController? allAdsController;
//
//   @override
//   Widget build(BuildContext context) {
//
//     double factor = 1920 / (Get.width - 48);
//
//
//     return StreamBuilder(
//       stream: Globals.userStream.getStream,
//       builder: (context, snapshot) {
//         return (Globals.userStream.user?.role?.viewAds == true)
//             ? LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   if (constraints.maxWidth > 300.0) {
//                     return GetBuilder(
//                       init: allAdsController,
//                       builder: (ctx)=>Container(
//                         height:(allAdsController!.listOfAdsSlider.isNotEmpty)? Get.width / 1.7:Get.width / 2.3,
//                         child: allAdsController!.isCallOutsLoaded.isTrue
//                             ?
//                         (allAdsController!.listOfAdsSlider.isNotEmpty)?
//                         AnimationLimiter(
//                           child: Stack(
//                             children: [
//                               Column(
//                                 children: [
//                                   Expanded(
//                                     child: PageView.builder(
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: buildTvItem,
//                                       controller: allAdsController!
//                                           .callOutPageController,
//                                       scrollDirection:
//                                       Axis.horizontal,
//                                       onPageChanged: allAdsController!
//                                           .onAdPageChanged,
//                                       itemCount: allAdsController!
//                                           .listOfAdsSlider.length,
//                                     ),
//                                   ),
//                                   SmoothPageIndicator(
//                                     controller: allAdsController!
//                                         .callOutPageController,
//                                     count: allAdsController!
//                                         .listOfAdsSlider.length,
//                                     effect: ExpandingDotsEffect(
//                                       dotHeight: 10.0,
//                                       dotWidth: 10.0,
//                                       activeDotColor:
//                                       ColorUtils.myRed,
//                                     ),
//                                     onDotClicked: (index) {},
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                             : AnimationLimiter(
//                           child: Stack(
//                             children: [
//                               Column(
//                                 children: [
//                                   Container(
//                                     height: 760 / factor,
//                                     width: 1920 / factor,
//                                     child: PageView.builder(
//                                       itemBuilder: buildTvItem,
//                                       controller: allAdsController!
//                                           .callOutPageController,
//                                       scrollDirection: Axis.horizontal,
//                                       onPageChanged:
//                                       allAdsController!.onAdPageChanged,
//                                       itemCount: allAdsController!
//                                           .listOfAdsSpecial.length,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8.0,),
//                                   SmoothPageIndicator(
//                                     controller: allAdsController!
//                                         .callOutPageController,
//                                     count:
//                                     allAdsController!.listOfAdsSpecial.length,
//                                     effect: ExpandingDotsEffect(
//                                       dotHeight: 10.0,
//                                       dotWidth: 10.0,
//                                       activeDotColor: ColorUtils.myRed,
//                                     ),
//                                     onDotClicked: (index) {},
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ): WidgetUtils.loadingWidget(),
//                       ),
//                     );
//                   } else {
//                     return Obx(
//                       () => Container(
//                         height: Get.width / 1.7,
//                         child: allAdsController!.isCallOutsLoaded.isTrue
//                             ? GetBuilder(
//                                 init: allAdsController!,
//                                 builder: (
//                                   context,
//                                 ) {
//                                   return AnimationLimiter(
//                                     child: Stack(
//                                       children: [
//                                         Column(
//                                           children: [
//                                             Expanded(
//                                               child: PageView.builder(
//                                                 itemBuilder: buildTvItem,
//                                                 controller: allAdsController!
//                                                     .callOutPageController,
//                                                 scrollDirection:
//                                                     Axis.horizontal,
//                                                 onPageChanged: allAdsController!
//                                                     .onAdPageChanged,
//                                                 itemCount: allAdsController!
//                                                     .listOfAdsSlider.length,
//                                               ),
//                                             ),
//                                             SmoothPageIndicator(
//                                               controller: allAdsController!
//                                                   .callOutPageController,
//                                               count: allAdsController!
//                                                   .listOfAdsSlider.length,
//                                               effect: ExpandingDotsEffect(
//                                                 dotHeight: 6.0,
//                                                 dotWidth: 6.0,
//                                                 activeDotColor:
//                                                     ColorUtils.myRed,
//                                               ),
//                                               onDotClicked: (index) {},
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 })
//                             : WidgetUtils.loadingWidget(),
//                       ),
//                     );
//                   }
//                 },
//               )
//             : Container(
//                 height: Get.height / 8,
//                 child: Center(
//                   child: WidgetUtils.button(
//                     onTap: () => Get.toNamed(
//                       RoutingUtils.upgradePlan.name,
//                     ),
//                     text: "ارتقا عضویت جهت مشاهده آگهی ها",
//                   ),
//                 ),
//               );
//       },
//     );
//   }
//
//   Widget buildPageIcon(BuildContext context, int index) {
//     return Obx(
//       () => AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         width: 8,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: allAdsController!.adCurrentPage.value.toInt() == index
//               ? ColorUtils.mainRed
//               : ColorUtils.mainRed.withOpacity(0.2),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTvItem(BuildContext context, int index) {
//     AdModel? call;
//     MainAdsModel? main;
//     if(allAdsController!.listOfAdsSlider.isNotEmpty){
//       call = allAdsController!.listOfAdsSlider[index];
//     }else {
//       main = allAdsController!.listOfAdsSpecial[index];
//     }
//     return AnimationConfiguration.staggeredList(
//       position: index,
//       child: SlideAnimation(
//         verticalOffset: index * 25.0,
//         child: FadeInAnimation(
//           child: GestureDetector(
//             onTap: () async {
//
//               if(call is AdModel){
//                 Get.to(()=>AdInfoScreen(
//                   ad: call!,
//                 ));
//               }
//             },
//             child: Container(
//               margin: const EdgeInsets.all(8.0),
//               width: Get.width / 1.2,
//               child: Container(
//                 width: Get.width / 1.2,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: FadeInImage.assetNetwork(
//                     placeholder: 'assets/placeholder.jpg',
//                     image:(call is AdModel)? call.cover:main!.adBannerPic!,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
