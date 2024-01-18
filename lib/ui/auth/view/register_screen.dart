import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import '../../../../data/validators.dart';
import '../../../../values/my_colors.dart';
import '../../../../values/my_imgs.dart';
import '../../../widgets/widgets.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: bodyBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
              onPressed: () => Get.off(Login()),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: GetBuilder<AuthController>(builder: (_authController) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: authController.signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(0),
                        ),
                        Center(
                          child: Text(
                            "Create Account",
                            style: kSize24blackW400Text.copyWith(
                                color: primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(28),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "First Name",
                                  style: kSize16BlackW400Text,
                                ),
                                SizedBox(
                                  height: getHeight(12),
                                ),
                                CustomTextField(
                                  controller:
                                      authController.firstNameController,
                                  validator: (value) =>
                                      Validators.firstNameValidation(value!),
                                  width: getWidth(180),
                                  text: "First Name",
                                  length: 40,
                                  keyboardType: TextInputType.name,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: getWidth(12),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Name",
                                  style: kSize16BlackW400Text,
                                ),
                                SizedBox(
                                  height: getHeight(12),
                                ),
                                CustomTextField(
                                  controller: authController.lastNameController,
                                  validator: (value) =>
                                      Validators.lastNameValidation(value!),
                                  width: getWidth(180),
                                  text: "Last Name",
                                  length: 40,
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Email",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          // errorText: 'Please enter some text',
                          controller: authController.emailController,

                          text: "example@gmail.com",
                          // errorText: "",
                          length: 40,
                          validator: (value) =>
                              Validators.emailValidator(value!),
                          onChanged: (value) {
                            authController.update();
                          },
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Phone",
                          style: kSize16BlackW400Text,
                        ),
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text: "Referral Code ",
                        //     style: kSize16BlackW400Text,
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: "(Optional)",
                        //         //   textAlign: TextAlign.center,
                        //
                        //         style: kSize16BlackW400Text.copyWith(
                        //             color: blackColor.withOpacity(0.6)),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          controller: authController.phoneController,
                          text: "123456789",
                          length: 40,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        Text(
                          "CNIC",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          controller: authController.cnicController,
                          text: "3740123456789",
                          length: 13,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
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
                          autovalidateMode:
                              authController.passwordController.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            authController.update();
                          },
                          length: 40,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Confirm Password",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          controller: authController.confirmPassword,
                          validator: (value) =>
                              Validators.passwordValidator(value!),
                          text: "********",
                          length: 40,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),

                        SizedBox(
                          height: getHeight(22),
                        ),

                        Center(
                            child: CustomButton(
                          text: 'Sign up',
                          onPressed: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (authController.signUpFormKey.currentState!
                                .validate()) {
                              authController
                                  .createAccountWithEmailAndPassword();
                            }
                            // Get.to(() => GeneralQuestionnaireScreen(),
                            //     transition: Transition.rightToLeft);
                          },
                        )),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              // style: textTheme.headline5!.copyWith(
                              //   //   fontFamily: "TiemposHeadline-Regular",
                              //     color: black,
                              //     fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                // controller.image = null;
                                Get.off(() => Login());
                              },
                              child: Text(
                                " Sign in",
                                style: kSize16BlackW400Text.copyWith(
                                    color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(32),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )),
    );
  }
}
