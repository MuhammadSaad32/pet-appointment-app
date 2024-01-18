import 'package:get/get.dart';
import 'package:pet_appoinment_app/ui/maps/controllers/map_controller.dart';
import '../../ui/appoinment/controller/appoinment_controller.dart';
import '../../ui/auth/controllers/auth_controller.dart';
import '../../ui/home/controller/home_controller.dart';
import '../../ui/hospital/controller/hospital_controller.dart';
import '../../ui/profile/controller/profile_controller.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => MapController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => AppoinmentController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => HospitalController(), fenix: true);


    // TODO: implement dependencies
  }
}
