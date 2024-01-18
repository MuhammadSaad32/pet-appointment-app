import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_appoinment_app/data/local_storage/singleton.dart';
import 'package:pet_appoinment_app/values/my_imgs.dart';

import '../../../widgets/custom_toasts.dart';

class MapController extends GetxController {
  double? lat;
  double? lng;
  getCurrentLatLng() async {
    var permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      CustomToast.failToast(msg: "Location permission is denied");
    } else {
      Position? position = await Geolocator.getCurrentPosition();
      if (position != null) {
        lat = position.latitude;
        lng = position.longitude;
        print("lat is $lat");
        print("lng is $lng");
      } else {
        CustomToast.failToast(msg: "Failed to get current location.");
      }
    }
  }



  /// set odd marker
  Set<Marker> markers = {};
  double lat1 = 31.4543141;
  double lng1 = 74.2754132;

  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(31.4697, 74.2728), zoom: 15.0);

  onMapCreated1(GoogleMapController controller) {
    try {
      controller = (controller);
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      addMarkers1();
      // createPolylines();
      LatLngBounds bound;

      bound = LatLngBounds(
        northeast: LatLng(
            SingleToneValue.instance.dropLat == 0
                ? max(lat1, SingleToneValue.instance.currentLat)
                : max(SingleToneValue.instance.dropLat,
                    SingleToneValue.instance.currentLat),
            SingleToneValue.instance.dropLng == 0
                ? max(lng1, SingleToneValue.instance.currentLng)
                : max(SingleToneValue.instance.dropLng,
                    SingleToneValue.instance.currentLng)),
        southwest: LatLng(
            min(SingleToneValue.instance.dropLat,
                SingleToneValue.instance.currentLat),
            min(SingleToneValue.instance.dropLng,
                SingleToneValue.instance.currentLng)),
      );
      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 40);

      check(u2, controller);
      update();
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        print("No se pudo obtener la ubicación.");
        // currentLocation = null;
      }
      print(e);
    }
  }

  ///adding markers
  Future<void> addMarkers1() async {
    markers.add(Marker(
      // ignore: deprecated_member_use
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(100, 100)), MyImgs.logo1),
      markerId: const MarkerId("Pick Location"),
      position: SingleToneValue.instance.dropLat == 0 &&
              SingleToneValue.instance.dropLng == 0
          ? LatLng(lat1, lng1)
          : LatLng(SingleToneValue.instance.dropLat,
              SingleToneValue.instance.dropLng),
      infoWindow: InfoWindow(
        title: 'Pick Up',
        snippet: '${SingleToneValue.instance.dropAddress}',
      ),
    ));

    update();
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    c.moveCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }
}
