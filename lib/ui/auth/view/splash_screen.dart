import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/ui/auth/controllers/auth_controller.dart';
import 'package:pet_appoinment_app/values/size_config.dart';

import '../../../utils/text_styles.dart';
import '../../../values/my_colors.dart';
import '../../../values/my_imgs.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController=Get.find();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      authController.checkUserSession();
      // Get.to(WalkThroughScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyImgs.logo1,
              width: getWidth(300),
              height: getHeight(300),
            ),
            Text("Pet Care",style: kSize20WhiteW400Text,),

          ],
        ),
      ),
    );
  }
}
