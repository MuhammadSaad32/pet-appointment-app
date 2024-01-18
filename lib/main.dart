import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pet_appoinment_app/ui/auth/view/register_screen.dart';
import 'package:pet_appoinment_app/ui/auth/view/splash_screen.dart';
import 'package:pet_appoinment_app/ui/maps/view/map_test_screen.dart';
import 'data/data_bindings/data_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: DataBindings(),
        ),
      ],
    );
  }
}
