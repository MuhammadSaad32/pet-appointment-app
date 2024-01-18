import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/ui/profile/pet_profile.dart';
import 'package:pet_appoinment_app/ui/profile/terms_condition_screen.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'package:pet_appoinment_app/widgets/custom_button.dart';
import 'package:pet_appoinment_app/widgets/custom_textfield.dart';
import '../../values/my_fonts.dart';
import '../../values/my_imgs.dart';
import '../auth/controllers/auth_controller.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  AuthController authController = Get.find();
  ProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyBackground.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: const Text(
            "Profile",
          ),
        ),
        body: Visibility(
          visible: true,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Profile Information',
                    //   style: TextStyle(
                    //     fontSize: 24.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(height: 16.0),
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: primaryColor,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24.0),
                              const Text(
                                'Test User',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Software Engineer',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Profile Information',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "First Name: ",
                                          style: kSize18BlackW400Text.copyWith(
                                              color: secondaryColor
                                                  .withOpacity(0.6),
                                              fontFamily: MyFonts.inter),
                                          // children: <TextSpan>[
                                          //   TextSpan(
                                          //     text: "Test",
                                          //     //   textAlign: TextAlign.center,
                                          //
                                          //     style:
                                          //         kSize20BlackW400Text.copyWith(
                                          //             color: secondaryColor),
                                          //   ),
                                          // ],
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      CustomTextField(
                                         controller: controller.firstNameController,
                                         text: 'Name',
                                         hintColor: blackColor,
                                         length: 40,
                                         keyboardType: TextInputType.text,
                                         inputFormatters:
                                         FilteringTextInputFormatter
                                             .singleLineFormatter),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "Last Name: ",
                                          style: kSize18BlackW400Text.copyWith(
                                              color: secondaryColor
                                                  .withOpacity(0.6),
                                              fontFamily: MyFonts.inter),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      CustomTextField(
                                          controller: controller.lastNameController,
                                          text: 'Last Name',
                                          hintColor: blackColor,
                                          length: 40,
                                          keyboardType: TextInputType.text,
                                          inputFormatters:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter),
                                      SizedBox(height: 8.0),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "Email: ",
                                          style: kSize18BlackW400Text.copyWith(
                                              color: secondaryColor
                                                  .withOpacity(0.6),
                                              fontFamily: MyFonts.inter),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      CustomTextField(
                                          controller: controller.emailController,
                                          text: 'Email',
                                          hintColor: blackColor,
                                          length: 40,
                                          keyboardType: TextInputType.emailAddress,
                                          inputFormatters:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter),
                                      SizedBox(height: 8.0),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "Phone: ",
                                          style: kSize18BlackW400Text.copyWith(
                                              color: secondaryColor
                                                  .withOpacity(0.6),
                                              fontFamily: MyFonts.inter),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      CustomTextField(
                                          controller: controller.phoneController,
                                          text: 'Phone Number',
                                          hintColor: blackColor,
                                          length: 11,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter),
                                      const SizedBox(height: 8.0),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "CNIC: ",
                                          style: kSize18BlackW400Text.copyWith(
                                              color: secondaryColor
                                                  .withOpacity(0.6),
                                              fontFamily: MyFonts.inter),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      CustomTextField(
                                          controller: controller.cnicController,
                                          text: 'Cnic',
                                          hintColor: blackColor,
                                          length: 13,
                                          keyboardType: TextInputType.number,
                                          inputFormatters:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter),
                                      const SizedBox(height: 10,),
                                      CustomButton(text: 'Update', onPressed: (){
                                      controller.updateProfile();
                                      controller.update();
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(height: 24.0),
                              //
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileScreenWidget(
                text: "Pet Profile",
                image: MyImgs.logo1,
                ontap: () async {
                  // final Email email = Email(
                  //   body: 'Email body Send from Flutter Test ',
                  //   subject: 'Email subject',
                  //   recipients: ['saadbuttdev@gmail.com'],
                  //
                  // );
                  //
                  // await FlutterEmailSender.send(email);
                  Get.to(PetProfileScreen());
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ProfileScreenWidget(
                text: "Customer Support",
                image: MyImgs.logo1,
                ontap: () {
                 controller.navigateToPhoneNumber('03125655199');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ProfileScreenWidget(
                text: "Terms & Conditions",
                image: MyImgs.logo1,
                ontap: () {
                  Get.to(()=>const TermsConditionScreen());
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ProfileScreenWidget(
                text: "Delete Account",
                image: MyImgs.logo1,
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Do you really want to delete your account?',
                          style: kSize16BlackW400Text,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              authController.deleteUser();
                            },
                          ),
                          TextButton(
                            child: const Text("CANCEL"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ProfileScreenWidget(
                text: "Logout",
                image: MyImgs.logo1,
                ontap: () async {
                  authController.logout();
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ProfileScreenWidget extends StatelessWidget {
  final String text;
  final String image;
  final Function() ontap;

  const ProfileScreenWidget({
    required this.text,
    required this.image,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: getHeight(60),
        decoration: const BoxDecoration(
          color: whiteColor,
          //  borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 16,
              ),
              Image.asset(
                image,
                height: 22,
                width: 22,
                color: secondaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: kSize16BlackW400Text,
              ),
              Expanded(
                  child: SizedBox(
                width: 20,
              )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15,
                color: blackColor.withOpacity(0.5),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
