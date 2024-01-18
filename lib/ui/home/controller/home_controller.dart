import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pet_appoinment_app/ui/profile/pet_profile.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import '../../../widgets/custom_toasts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<File> selectedImages = [];
  String? selectedGender;
  bool isLoading = false;
  String? petType;
  TextEditingController petController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  final picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadImagesAndAddToFirestore() async {
    // Set isLoading to true to show the progress indicator
    isLoading = true;
    update();
    List<String> imageUrls = [];

    try {
      for (var image in selectedImages) {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final reference = _storage.ref().child('images').child('$fileName.jpg');

        final uploadTask = reference.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});

        if (snapshot.state == firebase_storage.TaskState.success) {
          final downloadUrl = await reference.getDownloadURL();
          imageUrls.add(downloadUrl);
        }
      }

      final petData = {
        'petName': petController.text,
        'age': ageController.text,
        'breed':petBreedController.text,
        'weight':petWeightController.text,
        'species':petType,
        'gender': selectedGender,
        'imageUrls': imageUrls,
      };

      await _firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('myPets')
          .add(petData);

      selectedImages = [];
      selectedGender = null;
      petType = null;
      petController.clear();
      ageController.clear();
      petWeightController.clear();
      petBreedController.clear();
      petBreedController.clear();

      CustomToast.successToast(msg: 'Data Added Successfully');
      Get.off(PetProfileScreen());
    } catch (error) {
      CustomToast.failToast(msg: 'Failed to add data');
    } finally {
      // Set isLoading to false to hide the progress indicator
      isLoading = false;
      update();
    }
  }
  void addButton(BuildContext context) {
    if (selectedImages.isEmpty) {
      CustomToast.failToast(msg: 'Please Add at Least One Image');
    } else if (petController.text.isEmpty) {
      CustomToast.failToast(msg: 'Please Enter Pet Name');
    } else if (ageController.text.isEmpty) {
      CustomToast.failToast(msg: 'Please Enter Pet Age');
    }
    else if(petWeightController.text.isEmpty){
      CustomToast.failToast(msg: 'Please Enter Pet Weight');
    }
    else if (selectedGender == null) {
      CustomToast.failToast(msg: 'Please Select Gender');
    }
    else if (petType == null) {
      CustomToast.failToast(msg: 'Please Select Pet Type');
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      uploadImagesAndAddToFirestore().then((_) {
        Navigator.pop(context); // Close the progress dialog
      });
    }
  }
  var docId;
  Future<void> getHospitalEmail({required String email}) async {
    await _firestore
        .collection('hospitals')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      var emailData = value;
      for (var doc in emailData.docs) {
        docId = doc.id; // Access the ID of the document
        Get.log("Hospital document ID: $docId");
      }
    });
  }
  deleteFromHospital({required String email,required String timeStamp}) async {
    var d =await getHospitalEmail(email: email);
    final appointmentSnapshot=await  _firestore.collection('hospitals').doc(docId).collection('appointments ').where('time',isEqualTo:timeStamp).get();
    for (final appointmentDoc in appointmentSnapshot.docs) {
      await appointmentDoc.reference.delete();
    }
  }
  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      selectedImages
          .addAll(pickedFiles.map((file) => File(file.path)).toList());
      update();
    }
  }
}
