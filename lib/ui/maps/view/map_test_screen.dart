import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_appoinment_app/ui/maps/controllers/map_controller.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'dart:ui' as ui;

import '../../../utils/text_styles.dart';
import '../../../values/my_imgs.dart';
import '../../../widgets/custom_toasts.dart';
import '../../appoinment/view/appoinment_screen.dart';

class CityMapScreen extends StatefulWidget {
  const CityMapScreen({super.key});

  @override
  _CityMapScreenState createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  MapController mapController = Get.find();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = <Marker>{};
  double? currentLat;
  double? currentLng;

  @override
  void initState() {
    super.initState();
    // mapController.getCurrentLatLng();
    initializeMarkers();
  }

  void makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getCurrentCity() async {
    var permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      CustomToast.failToast(msg: "Location permission is denied");
    } else {
      try {
        // Get the current position (latitude and longitude)
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Reverse geocode the coordinates to get the city
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        // Extract the city from the placemarks
        if (placemarks.isNotEmpty) {
          String city = placemarks.first.locality ?? '';

          // Update the state with the current latitude and longitude values
          setState(() {
            currentLat = position.latitude;
            currentLng = position.longitude;
          });

          return city;
        }
      } catch (e) {
        print('Error getting current city: $e');
      }
    }

    return ''; // Return an empty string if the city cannot be determined
  }

  Future<Uint8List> _resizeImage(Uint8List imageData,
      {required int width, required int height}) async {
    final ui.Codec codec = await ui.instantiateImageCodec(imageData,
        targetWidth: width, targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image resizedImage = frameInfo.image;
    final ByteData? byteData =
        await resizedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void initializeMarkers() async {
    var userCity = await getCurrentCity();
    if (userCity == "Rawalpindi") {
      userCity = "Islamabad";
    }
    Get.log("current city is $userCity");

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('hospitals')
        .where('city', isEqualTo: "Islamabad")
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Clear existing markers before adding new ones
      _markers.clear();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String hospitalName = data['name'];
        double hospitalLat = double.parse(data['lat'] ?? '0.0');
        double hospitalLng = double.parse(data['lng'] ?? '0.0');
        String hospitalDetails = data['address'];
        String phoneNumber = data['phone number'] ?? '';
        String email = data['email'] ?? '';
        final ByteData byteData =
            await DefaultAssetBundle.of(context).load(MyImgs.imageIcon2);
        final Uint8List resizedImageData = await _resizeImage(
            byteData.buffer.asUint8List(),
            width: 70,
            height: 120);

        _markers.add(
          Marker(
            markerId: MarkerId(hospitalName),
            icon: BitmapDescriptor.fromBytes(resizedImageData),
            position: LatLng(hospitalLat, hospitalLng),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    height: getHeight(300),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: getHeight(100),
                              width: getWidth(80),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(MyImgs.imageIcon2),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(8)),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() =>
                                    AppoinmentScreen(email: data['email']));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'Book Now',
                                style: kSize14WhiteW400Text,
                              ),
                            ),
                            SizedBox(height: getHeight(8)),
                            ElevatedButton(
                              onPressed: () {
                                makePhoneCall(phoneNumber);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'Call Now',
                                style: kSize14WhiteW400Text,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: getWidth(12)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: getWidth(150),
                              child: Text(
                                hospitalName,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: getFont(24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(10)),
                            SizedBox(
                              width: getWidth(250),
                              child: Text(
                                hospitalDetails,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: getFont(16),
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(16)),
                            Text(
                              'Phone: ${phoneNumber}',
                              style: TextStyle(
                                fontSize: getFont(14),
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              'Email: $email',
                              style: TextStyle(
                                fontSize: getFont(14),
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(height: getHeight(12)),
                          ],
                        ),
                      ],
                    ),
                  );
                  // return Container(
                  //   padding: const EdgeInsets.all(16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text(
                  //         hospitalName,
                  //         style: const TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Text(hospitalDetails),
                  //       const SizedBox(height: 8),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           CustomButton(
                  //             width: getWidth(150),
                  //             text: 'Book Appointment',
                  //             onPressed: () {
                  //               // Perform the desired action for booking an appointment
                  //             },
                  //           ),
                  //           CustomButton(
                  //             width: getWidth(150),
                  //             text: 'Call Now',
                  //             onPressed: () {
                  //               makePhoneCall(phoneNumber);
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              );
            },
          ),
        );
      }
    }

    // Update the state to reflect the changes in markers
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
      ),
      body: currentLat == null
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLat!, currentLng!),
                zoom: 10.5,
              ),
            ),
    );
  }
}
