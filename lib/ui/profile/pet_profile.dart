import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/ui/profile/controller/profile_controller.dart';
import 'package:pet_appoinment_app/ui/profile/pet_add_data_screen.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import '../../utils/text_styles.dart';
import '../../values/size_config.dart';

class PetProfileScreen extends StatelessWidget {
  ProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => PetDataScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pet Profile'),
        backgroundColor: primaryColor,
      ),
      body: GetBuilder<ProfileController>(
        builder: (ctr) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('myPets')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: primaryColor,
                        ),
                      );
                    }

                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No data available.'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document = snapshot.data!.docs[index];
                          Map<String, dynamic> petData =
                              document.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ExpansionTile(
                                    title: Text(petData['petName'],
                                        style: kSize16BlackW400Text),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(20)),
                                        child: SizedBox(
                                          height: getHeight(200),
                                          width: getWidth(300),
                                          child: PageView(
                                            controller: PageController(initialPage: 0),
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (var image in petData['imageUrls'])
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(16.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: getHeight(20)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(20)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            PetProfileRow(
                                                title: 'Breed', value: petData['breed']),
                                            PetProfileRow(
                                                title: 'Species', value: petData['species']),
                                            SizedBox(height: getHeight(10)),
                                            PetProfileRow(
                                                title: 'Weight', value: petData['weight']),
                                            SizedBox(height: getHeight(10)),
                                            PetProfileRow(
                                                title: 'Age',
                                                value: " ${petData['age']} Year"),
                                            SizedBox(height: getHeight(10)),
                                            PetProfileRow(
                                                title: 'Gender',
                                                value: petData['gender']),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap:(){
                                     ctr.deletePetData(document: document.id);
                                     ctr.update();

                                    },
                                    child: const Icon(Icons.delete)),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class PetProfileRow extends StatelessWidget {
  String title;
  String value;
  PetProfileRow({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: getHeight(50),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: kSize16BlackW400Text),
            Text(value, style: kSize16BlackW400Text),
          ],
        ),
      ),
    );
  }
}
