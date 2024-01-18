import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_appoinment_app/ui/hospital/controller/hospital_controller.dart';
import '../../../data/validators.dart';
import '../../../utils/text_styles.dart';
import '../../../values/my_imgs.dart';
import '../../../values/size_config.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';


class HospitalLoginInScreen extends StatelessWidget {
  HospitalController controller = Get.find();
  HospitalLoginInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: GetBuilder<HospitalController>(builder: (ctr) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: Form(
                key: ctr.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(16),
                    ),
                    Center(
                        child: Image.asset(
                      MyImgs.logo1,
                      height: getHeight(200),
                    )),
                    Center(child: Text("Pet Care",style: kSize20WhiteW400Text,),),


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
                      controller: ctr.emailController,
                      validator: (value) => Validators.emailValidator(value!),
                      text: "example@gmail.com",
                      length: 40,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: ctr.passwordController,
                      validator: (value) =>
                          Validators.passwordValidator(value!),
                      text: "********",
                      obscureText: true,
                      suffixIcon: Icons.visibility,
                      autovalidateMode: ctr.passwordController.text.isNotEmpty
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChanged: (value) {
                        ctr.update();
                      },
                      length: 40,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                          FilteringTextInputFormatter.deny(RegExp('[ ]')),
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
                        if (ctr.loginFormKey.currentState!.validate()) {
                          // authController.resetPassword();
                          ctr.signInWithEmailAndPassword();
                        }
                      },
                    )),
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
