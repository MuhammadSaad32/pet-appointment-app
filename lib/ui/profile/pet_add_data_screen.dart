import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/validators.dart';
import '../../values/my_colors.dart';
import '../../values/size_config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../home/controller/home_controller.dart';
import 'package:get/get.dart';

class PetDataScreen extends StatelessWidget {
  HomeController controller = Get.find<HomeController>();
  PetDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet Data'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(builder: (ctr) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                CustomTextField(
                  text: 'Pet Name',
                  length: 30,
                  controller: ctr.petController,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
                SizedBox(height: getHeight(10.0)),
                CustomTextField(
                  text: 'Age (in years)',
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.number,
                  length: 30,
                  controller: ctr.ageController,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: blackColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: const Text(
                        ' Gender',
                        style: TextStyle(color: hintText),
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                      value: ctr.selectedGender,
                      onChanged: (value) {
                        ctr.selectedGender = value;
                        ctr.update();
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
                const SizedBox(height: 16.0),
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
                    text: 'Pet Weight (In Kg)',
                    length: 3,
                    validator: (value) => Validators.weightValidator(value!),
                    controller: controller.petWeightController,
                    keyboardType: TextInputType.number,
                    inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
                SizedBox(height: getHeight(10.0)),
                CustomTextField(
                    text: 'Pet Breed ',
                    length: 50,
                    validator: (value) => Validators.nameValidator(value!),
                    controller: controller.petBreedController,
                    keyboardType: TextInputType.text,
                    inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
                CustomButton(
                  text: 'Add Images',
                  onPressed: () {
                    ctr.pickImages();
                  },
                ),
                SizedBox(height: getHeight(20)),
                ctr.selectedImages.isEmpty
                    ? const Text('No Images Selected')
                    : CarouselSlider(
                        items: ctr.selectedImages.map((image) {
                          return Image.file(image);
                        }).toList(),
                        options: CarouselOptions(
                          height: getHeight(150),
                          enableInfiniteScroll: false,
                        ),
                      ),
                SizedBox(height: getHeight(20)),
                CustomButton(
                  text: 'Add',
                  onPressed: () {
                    ctr.addButton(context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
