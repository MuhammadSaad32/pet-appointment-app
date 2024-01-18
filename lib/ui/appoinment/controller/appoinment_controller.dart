import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_toasts.dart';

class AppoinmentController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  String? selectedGender;
  String? petType;
  GlobalKey<FormState> appointmentFormKey = GlobalKey();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<void> send({required String receiverEmail}) async {
    final Email email = Email(
      body: 'Hi,\n I would like to schedule an appointment for the following details:\n'
          'Owner Name :${nameController.text} \n'
          'Owner Email :${emailController.text}\n '
          'Phone Number :${phoneController.text}\n'
          'Pet Name : ${petNameController.text}\n'
          'Pet Age : ${petAgeController.text}\n '
          'pet Gender : $selectedGender\n'
          'pet Breed : ${petBreedController.text}\n'
          'Pet Type : $petType\n'
          'Pet Weight:  ${petWeightController.text}\n \nThank You',

      subject: 'Appointment For My Pet',
      recipients: [receiverEmail],
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      Get.log(error.toString());
    }
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }
  Future<String> getDocumentIdByEmail(String receiverEmail) async {
    CollectionReference hospitalCollection = FirebaseFirestore.instance.collection('hospitals');

    // Query the collection to get the document with matching email
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await hospitalCollection.where('email', isEqualTo: receiverEmail).limit(1).get() as QuerySnapshot<Map<String, dynamic>>;

    // Check if any document matches the query
    if (snapshot.size > 0) {
      // Return the document ID of the first document found
      return snapshot.docs.first.id;
    } else {
      // No matching document found
      return ""; // Return an empty string instead of null
    }
  }
  onButton({required String receiverEmail}) async {
    if (selectedGender == null) {
      CustomToast.failToast(msg: 'Please Select Pet Gender');
    } else if (petType == null) {
      CustomToast.failToast(msg: 'Please Select Species');
    } else if (appointmentFormKey.currentState!.validate()) {
      String documentId = await getDocumentIdByEmail(receiverEmail);
      //Get.log('doc is is $documentId');
      send(receiverEmail: receiverEmail);
      var doc = DateTime.now().microsecondsSinceEpoch;
      fireStore.collection('hospitals').doc(documentId).collection('appointments').add({
        'name': nameController.text,
        'email': emailController.text,
        'hospitalEmail': receiverEmail,
        'phoneNumber': phoneController.text,
        'petName': petNameController.text,
        'petAge': petAgeController.text,
        'gender': selectedGender,
        'petType': petType,
        'petBreed': petBreedController.text,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'time': doc.toString(),
        'status':'pending',
        'petWeight': petWeightController.text
      });
      fireStore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('appointments').doc(doc.toString()).set({
        'name': nameController.text,
        'email': emailController.text,
        'hospitalEmail': receiverEmail,
        'phoneNumber': phoneController.text,
        'petName': petNameController.text,
        'petAge': petAgeController.text,
        'gender': selectedGender,
        'petType': petType,
        'petBreed': petBreedController.text,
        'status':'pending',
        'id':FirebaseAuth.instance.currentUser!.uid,
        'time': doc.toString(),
        'petWeight': petWeightController.text
      });

     

      Get.log(
          "$selectedGender : $petType: ${nameController.text} : ${emailController.text} :${petBreedController.text}: ${phoneController.text} :${petNameController.text} :${petAgeController.text} :${petWeightController.text} :");
    }
  }
}
