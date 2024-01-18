import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/ui/auth/view/login_screen.dart';
import 'package:pet_appoinment_app/ui/bottom_nav/bottom_nav_screen.dart';
import '../../../data/services/CheckConnectionService.dart';
import '../../../widgets/widgets.dart';
import '../../home/home_screen.dart';

class AuthController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPassword = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final cnicController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  CheckConnectionService connectionService = CheckConnectionService();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference currenciesRef =
      FirebaseFirestore.instance.collection('currency');

  ///Create account
  createAccountWithEmailAndPassword() async {
    if (passwordController.text == confirmPassword.text) {
      Get.dialog(ProgressBar(), barrierDismissible: false);
      connectionService.checkConnection().then((value) async {
        if (!value) {
          CustomToast.failToast(msg: "No Internet Connection".tr);
          Get.back();
        } else {
          try {
            await auth
                .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              CustomToast.successToast(msg: "Account created successfully!");
              Future.wait([
                addUserData(),
              ]);

              Get.back();
              Get.off(() => Login());
            }, onError: (error) {
              Get.back();
              if (error.toString().contains("SocketException")) {
                CustomToast.failToast(
                  msg: "Please check your internet!".tr,
                  // message
                );
              }
            });
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              CustomToast.failToast(msg: "The password provided is too weak.");
            } else if (e.code == 'email-already-in-use') {
              CustomToast.failToast(msg: "email-already-in-use");
            }
            Get.back();
          } catch (e) {
            print(e);
          }
        }
      });
    } else {
      CustomToast.failToast(msg: "Both passwords should be same");
    }
  }

  ///add user data to firebase
  Future addUserData() {
    return users.doc(auth.currentUser!.uid).set({
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'cnic': cnicController.text,
    }).then((value) {
      ///optional
    }).catchError(
        (error) => CustomToast.failToast(msg: "Failed to add user$error"));
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
          await auth
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
            Get.back();
            Get.offAll(() => const BottomNavigation(),
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

  ///check session
  void checkUserSession() {
    final User? user = auth.currentUser;

    if (user != null) {
      Get.offAll(() => const BottomNavigation(),
          transition: Transition.rightToLeft);
    } else {
      Get.offAll(() => Login(), transition: Transition.rightToLeft);
    }
  }

  ///Logout
  void logout() async {
    Get.dialog(ProgressBar(), barrierDismissible: false);

    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        Get.back();
      } else {
        try {
          await auth.signOut().then((value) {
            Get.back();
            Get.offAll(() => Login(), transition: Transition.rightToLeft);
            // CustomToast.successToast(msg: "Logout successfully!");
          }, onError: (error) {
            Get.back();
            if (error.toString().contains("SocketException")) {
              CustomToast.failToast(msg: "Please check your internet!".tr);
            }
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  ///delete user
  void deleteUser() async {
    Get.dialog(ProgressBar(), barrierDismissible: false);

    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        Get.back();
      } else {
        try {
          User? user = auth.currentUser;

          if (user != null) {
            await user.delete().then((value) {
              Get.back();
              Get.offAll(() => Login(), transition: Transition.rightToLeft);
              CustomToast.successToast(msg: "User deleted successfully!");
            }, onError: (error) {
              Get.back();
              if (error.toString().contains("SocketException")) {
                CustomToast.failToast(msg: "Please check your internet!".tr);
              } else {
                CustomToast.failToast(msg: "Failed to delete user.");
              }
            });
          } else {
            CustomToast.failToast(msg: "No user found.");
            Get.back();
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
