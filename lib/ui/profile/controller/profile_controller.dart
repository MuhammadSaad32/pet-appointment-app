import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pet_profile.dart';

class ProfileController extends GetxController{
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  /// current user data
  getData(){
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
      firstNameController.text = value['first_name'];
      lastNameController.text = value['last_name'];
      emailController.text = value['email'];
      phoneController.text = value['phone'];
      cnicController.text = value['cnic'];
    });

  }
  void navigateToPhoneNumber(String phoneNumber) async {
    String formattedPhoneNumber = 'tel:$phoneNumber';

    if (await canLaunch(formattedPhoneNumber)) {
      await launch(formattedPhoneNumber);
    } else {
      throw 'Could not launch $formattedPhoneNumber';
    }
  }
  updateProfile(){
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'first_name':firstNameController.text,
      'last_name':lastNameController.text,
      'email':emailController.text,
      'phone':phoneController.text,
      'cnic':cnicController.text,
    });
  }
  deletePetData({required String document}){
    Get.log("document id is $document");
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('myPets')
        .doc(document)
        .delete().then((value){
          Get.to(()=>PetProfileScreen());
    });
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();

  }
}