import 'package:flutter/material.dart';
import 'package:paakaar/Controllers/Splash/splash_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/image_utils.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController controller = Get.put(
    SplashController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints raints) {
          if (raints.maxWidth > 480.0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width * .4,
                      height: Get.width * .4,
                      child: const Image(
                        image: AssetImage(
                          ImageUtils.logo,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'پاکار',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width * .4,
                      height: Get.width * .4,
                      child: const Image(
                        image: AssetImage(
                          ImageUtils.logo,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .05,),
                  const Text(
                    'پـــاکـــار',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
