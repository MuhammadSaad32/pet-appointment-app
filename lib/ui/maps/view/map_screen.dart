import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_appoinment_app/ui/home/booking_screen.dart';
import 'package:pet_appoinment_app/ui/maps/controllers/map_controller.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';
import 'package:pet_appoinment_app/values/my_imgs.dart';
import 'package:pet_appoinment_app/values/size_config.dart';

class MapScreen extends StatefulWidget {


   MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController =Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated:mapController.onMapCreated1 ,
              markers: mapController.markers,
              initialCameraPosition:
              const CameraPosition(target: LatLng(31.4697, 74.2728), zoom: 15.0),
            ),
            Positioned(
              top: getHeight(30),
              left: getWidth(20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(
                  MyImgs.logout,
                ),
              ),
            ),
            Positioned(
              top: getHeight(440),
              left: getWidth(320),
              child: Container(
                width: getWidth(148),
                height: getHeight(40),
                decoration: BoxDecoration(
                  color: Color(0xffB5FB1E),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: getWidth(14),
                    ),
                    const Icon(Icons.map_outlined),
                    SizedBox(
                      width: getWidth(4),
                    ),
                    Text(
                      'Map',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: getFont(16)),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: getHeight(485),
              left: getWidth(320),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>BookingScreen());
                  // Navigator.pushNamed(context, ProductsListScreen.id);
                },
                child: Container(
                  width: getWidth(148),
                  height: getHeight(40),
                  decoration: BoxDecoration(
                    color: const Color(0xffB5FB1E),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: getWidth(14),
                      ),
                      const Icon(Icons.list),
                      SizedBox(
                        width: getWidth(4),
                      ),
                      Text(
                        'List',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: getFont(16)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: getWidth(414),
          height: getHeight(280),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(36),
                topLeft: Radius.circular(36),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)
            ),

          ),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              controller: ScrollController(),
              itemBuilder: (context, index) {
                return Padding(
                  // padding need to be set
                  padding: EdgeInsets.only(
                    top: 50,
                    left: 20,
                    right: 10,
                    bottom: 12  ,
                    // vertical: getHeight(30),
                    // horizontal: getWidth(10)),
                  ),
                  child: Container(
                    width: getWidth(280),
                    height: getHeight(200),
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.4),
                        borderRadius:
                        BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff000000)
                                  .withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    MyImgs.logo1,
                                    width: getWidth(120),
                                    height: getHeight(
                                      130,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Color(0xffB5FB1E),
                                      size: getWidth(15),
                                    ),
                                    backgroundColor: Colors.black,
                                    radius: getWidth(12),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(10)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getHeight(10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 20,
                                        foregroundImage: AssetImage(
                                            MyImgs.logout),
                                      ),
                                      SizedBox(
                                        width: getWidth(6),
                                      ),
                                      SizedBox(
                                        width: getWidth(88),
                                        height: getHeight(36),
                                        child: Text(
                                          'testing one ',

                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: getFont(
                                                  14),
                                              color: Colors.white),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(9),
                                  ),

                                  //new column from time widget
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // RatingBarIndicator(
                                          //   rating: 5,
                                          //   itemBuilder:
                                          //       (context, index) =>
                                          //       Icon(
                                          //         Icons.star,
                                          //         color:
                                          //         Color(0xffB5FB1E),
                                          //       ),
                                          //   itemCount: 5,
                                          //   itemSize:
                                          //   12,
                                          //   direction:
                                          //   Axis.horizontal,
                                          // ),
                                          SizedBox(
                                            width: getWidth(
                                                8),
                                          ),
                                          Text(
                                            '(45 reviews)',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w300,
                                                fontSize: getFont(
                                                    9),
                                                color: Colors.white
                                                    .withOpacity(
                                                    0.38)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: getHeight(10  ),),
                                      Row(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            color: Colors.white,
                                            size: 13,
                                          ),
                                          SizedBox(
                                            width:
                                            getWidth(10),
                                          ),
                                          Text(
                                            '09:00 am - 11:00 pm',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w300,
                                                fontSize: getFont(
                                                    10),
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getHeight(10),
                                      ),
                                      Text(
                                        'Price : €50',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            getFont(12),
                                            color: Colors.white),
                                      ),
                                      // SizedBox(
                                      //   height: getHeight(2),
                                      // ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(36),),
                        Row(
                          // mainAxisAlignment:
                          // MainAxisAlignment
                          //     .spaceBetween,
                          children: [
                            SizedBox(width: getWidth(20),),
                            Image.asset(
                              MyImgs.logout,
                              width:
                              getWidth(19),
                              height: getHeight(
                                  19),
                            ),
                            SizedBox(
                              width:
                              getWidth(15),
                            ),
                            Container(
                              width:
                              getWidth(36),
                              height: getHeight(
                                  36),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons
                                    .chat_bubble_outline_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(
                              width:
                              getWidth(15),
                            ),
                            Container(
                              width:
                              getWidth(36),
                              height: getHeight(
                                  36),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
