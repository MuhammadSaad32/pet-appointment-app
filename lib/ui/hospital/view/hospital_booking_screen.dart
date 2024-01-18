import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/ui/hospital/controller/hospital_controller.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'package:pet_appoinment_app/values/values.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/widgets/custom_button.dart';

import '../../auth/view/login_screen.dart';

class HospitalBookingScreen extends StatelessWidget {
  HospitalController controller = Get.find();
  final String hospitalDocument;
  HospitalBookingScreen({super.key, required this.hospitalDocument});

  @override
  Widget build(BuildContext context) {
    Get.log("doc received is $hospitalDocument");
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Hospital Bookings"),
          centerTitle: true,
          backgroundColor: primaryColor,
         leading: GestureDetector(onTap:() async {
           await FirebaseAuth.instance.signOut().then((value){
             Get.offAll(Login());
           });
         },child: const Icon(Icons.logout,color: Colors.white,)),
      ),

      body: GetBuilder<HospitalController>(builder: (ctr) {
        return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('hospitals')
              .doc(hospitalDocument)
              .collection('appointments')
              .where('status', isEqualTo: 'pending')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child:Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No Appointments Yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
                );
              } else {
                final bookings = snapshot.data!;
                return ListView.builder(
                  itemCount: bookings.docs.length,
                  itemBuilder: (context, index) {
                    final booking = bookings.docs[index];
                    final bookingId = booking.reference.id;
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          '${bookings.docs[index]['name']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Pet: ${bookings.docs[index]['petName']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Species: ${bookings.docs[index]['petType']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Breed: ${bookings.docs[index]['petBreed']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Age: ${bookings.docs[index]['petAge']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Weight: ${bookings.docs[index]['petWeight']} kg',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Gender: ${bookings.docs[index]['gender']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                            Column(
                              children: [
                                CustomButton(
                                  text: 'Approve',
                                  onPressed: () {
                                    ctr.updateBookingStatus(bookingId,
                                        'complete', hospitalDocument);
                                    ctr.updateBookingStatusUser(bookingId: snapshot.data!.docs[index]['time'],
                                        newStatus: 'complete',doc:  snapshot.data!.docs[index]['id']);
                                    ctr.update();
                                  },
                                  height: getHeight(50),
                                  width: getWidth(150),
                                ),
                                SizedBox(
                                  height: getHeight(30),
                                ),
                                CustomButton(
                                  text: 'Cancel',
                                  onPressed: () {
                                    ctr.updateBookingStatus(
                                        bookingId, 'cancel', hospitalDocument);
                                    ctr.updateBookingStatusUser(bookingId: snapshot.data!.docs[index]['time'],
                                        newStatus: 'cancel',doc:  snapshot.data!.docs[index]['id']);
                                    ctr.update();
                                  },
                                  height: getHeight(50),
                                  width: getWidth(150),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle booking tap
                        },
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(child: Text('No bookings found.'));
            }
          },
        );
      }),
    );
  }
}
