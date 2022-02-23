import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paakaar/Models/Club/Services/VoucherCodes/VoucherCodeProviderModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class VoucherCodeInfoDialog extends StatefulWidget {
  final VoucherCodeProviderModel codeProvider;
  final Function reset;
  VoucherCodeInfoDialog(
      {Key? key, required this.codeProvider, required this.reset})
      : super(key: key);

  @override
  _VoucherCodeInfoDialogState createState() => _VoucherCodeInfoDialogState();
}

class _VoucherCodeInfoDialogState extends State<VoucherCodeInfoDialog> {
  bool noAccess = false;

  get size => MediaQuery.of(Get.context!).size;

  String? code;

  bool get isLoaded => this.code != null && this.code!.length > 0;
  @override
  void initState() {
    (ClubRequestUtils())
        .getVoucherCodeInfo(this.widget.codeProvider.code!)
        .then((ApiResult result) {
      if (result.isDone) {
        this.setState(() {
          this.code = result.data;
        });
      } else {
        this.setState(() {
          this.noAccess = true;
        });
      }
    });
    super.initState();
  }

  Widget closeButton() {
    return WidgetUtils.closeButton(
      ColorUtils.textColor,
    );
  }

  Widget header() {
    return Row(
      children: [
        this.closeButton(),
        SizedBox(
          width: 8.0,
        ),
        Text(
          'کد تخفیف ${this.widget.codeProvider.percent} درصدی از ${this.widget.codeProvider.name}',
          style: TextStyle(
            fontSize: 15.0,
            color: ColorUtils.textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: Get.width / 1.1,
          height: Get.height / 3,
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  this.header(),
                  SizedBox(
                    height: 16.0,
                    child: WidgetUtils.separator(),
                  ),
                  this.noAccess ? this.noAccessWidget() : this.body(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return this.isLoaded
        ? Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Clipboard.setData(
                  ClipboardData(text: this.code),
                );
                this.widget.reset();
                ViewUtils.showInfoDialog("کپی شد!");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.all(2.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(),
                      Icon(
                        Icons.copy_outlined,
                        size: 50.0,
                        color: ColorUtils.yellow,
                      ),
                      Text(
                        "${this.code}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: ColorUtils.yellow,
                        ),
                      ),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: Container(
              width: Get.width / 2,
              height: Get.width / 2,
              child: WidgetUtils.loadingWidget(),
            ),
          );
  }

  Widget noAccessWidget() {
    return Expanded(
      child: Center(
        child: Text(
          "دسترسی صادر نشد!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
