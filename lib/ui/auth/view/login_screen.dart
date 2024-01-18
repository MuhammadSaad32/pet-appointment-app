

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_appoinment_app/ui/auth/view/register_screen.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import '../../../../data/validators.dart';
import '../../../../values/my_colors.dart';
import '../../../../values/my_imgs.dart';
import '../../../../values/size_config.dart';
import '../../../widgets/widgets.dart';

import '../../hospital/view/hospital_login_screen.dart';
import '../controllers/auth_controller.dart';

class Login extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (_authController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child:Form(
                key: authController.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(16),
                    ),
                    Center(child: Image.asset(MyImgs.logo1,height: getHeight(200),)),
                    Center(child: Text("Pet Care",style: kSize14WhiteW400Text,),),
                    

                    Center(
                      child: Text(
                        "Sign in To Your Account",
                        style: kSize24blackW400Text,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(28),
                    ),
                    Text(
                      "Email",
                      style: kSize16BlackW400Text,
                    ),
                    SizedBox(
                      height: getHeight(12),
                    ),
                    CustomTextField(
                      controller: authController.emailController,
                      validator: (value) =>
                          Validators.emailValidator(value!),
                      text: "example@gmail.com",
                      length: 40,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: FilteringTextInputFormatter
                          .singleLineFormatter,
                    ),
                    SizedBox(
                      height: getHeight(16),
                    ),
                    Text(
                      "Password",
                      style: kSize16BlackW400Text,
                    ),
                    SizedBox(
                      height: getHeight(12),
                    ),
                    CustomTextField(
                      controller: authController.passwordController,
                      validator: (value) =>
                          Validators.passwordValidator(value!),
                      text: "********",
                      obscureText: true,
                      suffixIcon: Icons.visibility,
                      autovalidateMode: authController
                          .passwordController.text.isNotEmpty
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChanged: (value) {
                        authController.update();
                      },
                      length: 40,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                      FilteringTextInputFormatter.deny(
                          RegExp('[ ]')),
                    ),
                    // SizedBox(
                    //   height: getHeight(24),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         // Get.to(() => ForgotPasswordScreen());
                    //       },
                    //       child: Text(
                    //         "ForgotPassword?",
                    //         style: kSize16BlackW400Text,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: getHeight(40),
                    ),
                    Center(
                        child: CustomButton(
                          text: 'Sign in',
                          onPressed: () {
                            // Get.offAll(() => GeneralQuestionnaireScreen());
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (authController.loginFormKey.currentState!
                                .validate()) {
                              // authController.resetPassword();
                              authController.signInWithEmailAndPassword();
                            }
                          },
                        )),
                    SizedBox(height: getHeight(12),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          // style: textTheme.headline5!.copyWith(
                          //   //   fontFamily: "TiemposHeadline-Regular",
                          //     color: black,
                          //     fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.image = null;
                            Get.off(() => RegisterScreen());
                          },
                          child: Text(
                            " Sign up",
                            style: kSize16BlackW400Text.copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(12),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login As? ",
                          // style: textTheme.headline5!.copyWith(
                          //   //   fontFamily: "TiemposHeadline-Regular",
                          //     color: black,
                          //     fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.image = null;
                            Get.to(() => HospitalLoginInScreen());
                          },
                          child: Text(
                            " Hospital",
                            style: kSize16BlackW400Text.copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(32),),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
