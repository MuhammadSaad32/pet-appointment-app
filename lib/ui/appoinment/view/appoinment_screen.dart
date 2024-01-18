import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pet_appoinment_app/ui/appoinment/controller/appoinment_controller.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'package:pet_appoinment_app/widgets/custom_textfield.dart';
import 'package:pet_appoinment_app/widgets/custom_toasts.dart';

import '../../../data/validators.dart';
import '../../../widgets/custom_button.dart';

class AppoinmentScreen extends StatelessWidget {
  String email;
  AppoinmentController ctr = Get.find();
  AppoinmentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Appoinment Screen"),
        centerTitle: true,
      ),
      body: GetBuilder<AppoinmentController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(16), vertical: getHeight(16)),
            child: Form(
              key: controller.appointmentFormKey,
              child: Column(
                children: [
                  CustomTextField(
                      text: 'Owner Name',
                      length: 50,
                      validator: (value) =>
                          Validators.firstNameValidation(value!),
                      controller: controller.nameController,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomTextField(
                      text: 'Email',
                      length: 50,
                      validator: (value) => Validators.emailValidator(value!),
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomTextField(
                      text: 'Phone Number',
                      length: 11,
                      validator: (value) => Validators.phoneNumber(value!),
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomTextField(
                      text: 'Pet Name',
                      length: 50,
                      validator: (value) =>
                          Validators.nameValidator(value!),
                      controller: controller.petNameController,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  Container(
                    width: double.infinity,
                    height: getHeight(55),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: blackColor.withOpacity(0.6)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text('Gender'),
                        // padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                        value: controller.selectedGender,
                        onChanged: (value) {
                          controller.selectedGender = value;
                          controller.update();
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomTextField(
                      text: 'Pet Age (In Years)',
                      length: 3,
                      validator: (value) => Validators.ageValidator(value!),
                      controller: controller.petAgeController,
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  SizedBox(height: getHeight(10),),
                  CustomTextField(
                      text: 'Pet Breed ',
                      length: 50,
                      validator: (value) => Validators.nameValidator(value!),
                      controller: controller.petBreedController,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  Container(
                    width: double.infinity,
                    height: getHeight(55),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: blackColor.withOpacity(0.6)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text('Species'),
                        // padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                        value: controller.petType,
                        onChanged: (value) {
                          controller.petType = value;
                          controller.update();
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'Dog',
                            child: Text('Dog'),
                          ),
                          DropdownMenuItem(
                            value: 'Cat',
                            child: Text('Cat'),
                          ),
                          DropdownMenuItem(
                            value: 'Bird',
                            child: Text('Bird'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomTextField(
                      text: 'Pet Weight',
                      length: 3,
                      validator: (value) => Validators.weightValidator(value!),
                      controller: controller.petWeightController,
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  CustomButton(
                    width: getWidth(300),
                    text: 'Book Appointment',
                    onPressed: () {
                      controller.onButton(receiverEmail: email);
                      Get.log("Id is ${FirebaseAuth.instance.currentUser!.uid}");
                      //controller.onButton(receiverEmail: 'saadiibutt32@gmail.com');
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
