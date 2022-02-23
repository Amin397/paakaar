import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Models/Club/Services/Internet/InternetPackage.dart';
import 'package:paakaar/Pages/Club/Internet/GetMobileNumberDialog.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class InternetPackageListModal extends StatefulWidget {
  final List<InternetPackage> listOfPackages;
  final String title;

  InternetPackageListModal({
    Key? key,
    required this.title,
    required this.listOfPackages,
  }) : super(key: key);

  @override
  _InternetPackageListModalState createState() =>
      _InternetPackageListModalState();
}

class _InternetPackageListModalState extends State<InternetPackageListModal> {
  int ticketType = 1;

  final TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          height: Get.height / 1.2,
          width: Get.width / 1.02,
          decoration: BoxDecoration(
            color: ColorUtils.black,
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  this.header(),
                  SizedBox(
                    height: Get.height / 25,
                  ),
                  this.searchWidget(),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  this.body(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return WidgetUtils.neuSearchField(
      controller: this.searchController,
      onChange: (String string) {
        this.widget.listOfPackages.forEach(
              (element) => element.showSearch = false,
            );
        this
            .widget
            .listOfPackages
            .where((element) => element.description.contains(string))
            .forEach(
              (element) => element.showSearch = true,
            );
        this.setState(() {});
      },
    );
  }

  Widget closeButton() {
    return WidgetUtils.closeButton(
      ColorUtils.textColor,
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            this.closeButton(),
            SizedBox(
              width: 5.0,
            ),
            Text(
              '${this.widget.title}',
              style: TextStyle(
                fontSize: 15.0,
                color: ColorUtils.textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget body() {
    return this
                .widget
                .listOfPackages
                .where((element) => element.showSearch)
                .length >
            0
        ? Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  WidgetUtils.separator(),
              itemBuilder: (BuildContext context, int index) => this
                  .packageBuilder(this
                      .widget
                      .listOfPackages
                      .where((element) => element.showSearch)
                      .toList()[index]),
              itemCount: this
                  .widget
                  .listOfPackages
                  .where((element) => element.showSearch)
                  .length,
            ),
          )
        : Expanded(
            child: Center(
              child: Text("بسته ای یافت نشد!"),
            ),
          );
  }

  Widget packageBuilder(InternetPackage package) {
    return Material(
      child: InkWell(
        onTap: () => this.buyPackage(package),
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          margin: EdgeInsets.only(top: 5.0),
          height: Get.height / 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wifi,
                    color: ColorUtils.yellow,
                    size: 35.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: Get.width / 1.6,
                    child: Text(
                      package.description,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.7,
                        color: ColorUtils.textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_right,
                    color: ColorUtils.yellow,
                    size: Get.width / 10,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buyPackage(InternetPackage package) async {
    String mobileNo = await GetMobileDialog.show();
    ApiResult result = await ClubRequestUtils.instance.buyPackage(
      packageCode: package.code,
      packageCost: package.price,
      mobile: mobileNo,
    );
    if (result.isDone) {
      launch(result.data['url']);
    } else {
      ViewUtils.showErrorDialog(
        result.data['message'].toString(),
      );
    }
  }
}
