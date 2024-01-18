import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/ui/appoinment/view/appoinment_screen.dart';
import 'package:pet_appoinment_app/ui/home/controller/home_controller.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'package:pet_appoinment_app/widgets/hospital_container.dart';
import '../../values/my_imgs.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: bodyBackground,
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            // height: getHeight(200),
            // Adjust the height as needed
            child: CarouselSlider(
              options: CarouselOptions(autoPlay: true,
                  enlargeCenterPage: true,
                  // padEnds: true
                  // Configure carousel options as per your requirement
                  ),
              items: [
                MyImgs.image1,
                MyImgs.image2,
                MyImgs.image3,
                MyImgs.image4,
                MyImgs.image5,
                // Add more image URLs here
              ].map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: getHeight(28),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('hospitals')
                .where('city', isEqualTo: "Islamabad")
                .get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: primaryColor,),);
              }
              else if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              else if(snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      return HospitalContainer(
                         function: (){
                           Get.to(()=>AppoinmentScreen(email: snapshot.data!.docs[index]['email']));
                         },
                        hospitalName: snapshot.data!.docs[index]['name'],
                        hospitalAddress: snapshot.data!.docs[index]['address'],
                        hospitalEmail: snapshot.data!.docs[index]['email'],
                        hospitalPhone: snapshot.data!.docs[index]['phone number'],
                      );
                    },
                  ),
                );
              }
              else{
                return const Text('No hospitals found.');
              }

            },
          ),
        ],
      ),
    );
  }
}

