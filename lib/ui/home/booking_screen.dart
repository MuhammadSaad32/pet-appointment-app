import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_appoinment_app/ui/home/controller/home_controller.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/size_config.dart';
import 'package:pet_appoinment_app/widgets/custom_button.dart';

class Booking {
  final String ownerName;
  final String ownerContact;
  final String ownerEmail;
  final String petName;
  final String species;
  final String breed;
  final int age;
  final double weight;
  final String gender;
  final BookingStatus status;

  Booking({
    required this.ownerName,
    required this.ownerContact,
    required this.ownerEmail,
    required this.petName,
    required this.species,
    required this.breed,
    required this.age,
    required this.weight,
    required this.gender,
    required this.status,
  });
}

enum BookingStatus {
  completed,
  cancelled,
  pending,
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        centerTitle: true,
        backgroundColor: primaryColor,
        bottom: TabBar(
          indicatorColor: primaryColor,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookingList('complete'),
              _buildBookingList('cancel'),
              _buildBookingList('pending'),
            ],
          );
        }
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchBookingsByStatus(String status) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointments')
        .where('status', isEqualTo: status)
        .get();

    return querySnapshot.docs;
  }

  Widget _buildBookingList(String status) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchBookingsByStatus(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if an error occurred
        } else if (snapshot.hasData) {
          final bookings = snapshot.data!;
          if (bookings.isEmpty) {
            if (status == 'complete') {
              return Center(
                  child: Container(
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
                      'No completed bookings.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ));
            } else if (status == 'pending') {
              return Center(
                  child: Container(
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
                      'No pending bookings.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ));
            } else if (status == 'cancel') {
              return Center(
                  child: Container(
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
                      'No cancelled bookings.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ));
            }
          } // Access the retrieved bookings from the snapshot
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getBookingIconColor(status),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        _getBookingIcon(status),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    '${booking['name']}',
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
                            'Pet: ${booking['petName']}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            'Species: ${booking['petType']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Breed: ${booking['petBreed']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Age: ${booking['petAge']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Weight: ${booking['petWeight']} kg',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Gender: ${booking['gender']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      if (status == 'pending')
                        CustomButton(
                            height: getHeight(50),
                            width: getWidth(100),
                            text: 'Cancel',
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('appointments')
                                  .doc(booking.id)
                                  .delete();
                              await Get.find<HomeController>().deleteFromHospital(email: booking['hospitalEmail'],timeStamp:booking['time'] );
                              Get.find<HomeController>().update();

                            })
                    ],
                  ),
                  onTap: () {
                    // Handle booking tap
                  },
                ),
              );
            },
          );
        } else {
          return const Text(
              'No bookings found.'); // Show a message when no bookings are available
        }
      },
    );
  }

  Color _getBookingIconColor(String status) {
    switch (status) {
      case 'complete':
        return Colors.green;
      case 'cancel':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getBookingIcon(String status) {
    switch (status) {
      case 'complete':
        return Icons.check_circle;
      case 'cancel':
        return Icons.cancel;
      case 'pending':
        return Icons.access_time;
      default:
        return Icons.help;
    }
  }
}
