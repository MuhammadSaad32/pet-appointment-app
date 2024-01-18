import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/data/services/CheckConnectionService.dart';
import 'package:pet_appoinment_app/ui/hospital/view/hospital_booking_screen.dart';
import 'package:pet_appoinment_app/ui/hospital/view/hospital_login_screen.dart';

import '../../../widgets/custom_toasts.dart';
import '../../../widgets/progress_bar.dart';

class HospitalController extends GetxController{
  GlobalKey<FormState> loginFormKey = GlobalKey();
  CheckConnectionService connectionService = CheckConnectionService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  ///Sign In
  signInWithEmailAndPassword() async {
    Get.dialog(ProgressBar(), barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        Get.back();
      } else {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text)
              .then((value) async {
               String doc = await getDocumentIdByEmail(emailController.text);
               Get.log("doc send is $doc");
            Get.back();
            Get.offAll(() => HospitalBookingScreen(hospitalDocument: doc),
                transition: Transition.rightToLeft);
            CustomToast.successToast(msg: "Login successfully!");
          }, onError: (error) {
            Get.back();
            if (error.toString().contains("SocketException")) {
              CustomToast.failToast(
                msg: "Please check your internet!".tr,
                // message
              );
            } else if (error.toString().contains(
                "The password is invalid or the user does not have a password")) {
              CustomToast.failToast(
                  msg: "Wrong password provided for that user.");
            } else if (error.toString().contains(
                "There is no user record corresponding to this identifier. The user may have been deleted.")) {
              CustomToast.failToast(msg: "No user found for that email.");
            }
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            CustomToast.failToast(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            CustomToast.failToast(
                msg: "Wrong password provided for that user.");
          }
          Get.back();
        } catch (e) {
          print("...............$e");
        }
      }
    });
  }

  void updateBookingStatus(String bookingId, String newStatus,String doc) {
    FirebaseFirestore.instance
        .collection('hospitals')
        .doc(doc)
        .collection('appointments')
        .doc(bookingId)
        .update({'status': newStatus})
        .then((_) {
      // Status update successful
    })

        .catchError((error) {
      // Error occurred during status update
      print('Error updating status: $error');
    });

  }
  void updateBookingStatusUser({required String bookingId, required String newStatus,required String doc}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(doc)
        .collection('appointments')
        .doc(bookingId)
        .update({'status': newStatus})
        .then((_) {
      // Status update successful
    })

        .catchError((error) {
      // Error occurred during status update
      print('Error updating status: $error');
    });

  }


}