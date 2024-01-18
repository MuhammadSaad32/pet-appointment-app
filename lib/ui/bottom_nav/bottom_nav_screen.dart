import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/values/my_colors.dart';

import '../../values/size_config.dart';
import '../home/booking_screen.dart';
import '../home/home_screen.dart';
import '../maps/view/map_test_screen.dart';
import '../profile/profile_screen.dart';
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
    List navBarScreens = [
      HomeScreen(),
       BookingScreen(),
      const CityMapScreen(),
      ProfileScreen(),
    ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          // fixedColor: MyColors.primaryColor,
          backgroundColor: primaryColor,
          unselectedItemColor: Colors.grey.shade700,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          selectedItemColor: bodyBackground,
          elevation: 0.0,
          // selectedItemColor: MyColors.splashColor, iconSize: Dimens.size20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,size: 30,),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined,size: 30,),
                label: 'Schedule'

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined,size: 30,),
                label: 'Maps'

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,size: 30,),
                label: 'Profile'
              // activeIcon:ImageIcon(AssetImage(MyImgs.foodIconBottom)),
            ),
          ]),
      body: navBarScreens[index],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pet_appoinment_app/ui/home/booking_screen.dart';
// import 'package:pet_appoinment_app/ui/home/home_screen.dart';
// import 'package:pet_appoinment_app/ui/maps/view/map_screen.dart';
// import 'package:pet_appoinment_app/ui/maps/view/map_test_screen.dart';
// import 'package:pet_appoinment_app/ui/profile/profile_screen.dart';
// import 'package:pet_appoinment_app/values/my_colors.dart';
// import 'package:pet_appoinment_app/values/size_config.dart';
//
//   class BottomNavScreen extends StatefulWidget {
//     final int indexx;
//
//     const BottomNavScreen({Key? key, required this.indexx}) : super(key: key);
//
//     @override
//     State<BottomNavScreen> createState() => _BottomNavScreenState();
//   }
//
//   class _BottomNavScreenState extends State<BottomNavScreen> {
//     List navBarScreens = [
//       const HomeScreen(),
//       const BookingScreen(),
//       const CityMapScreen(),
//       ProfileScreen(),
//     ];
//     List<String> navText = ['Home', 'My Schedule', 'My Jobs', 'Chats'];
//     List<IconData> navIcon = [
//       Icons.home_outlined,
//       Icons.library_books_outlined,
//       Icons.map_outlined,
//       Icons.person_outline
//     ];
//     int currentIndex = 0;
//
//     @override
//     Widget build(BuildContext context) {
//       SizeConfig().init(context);
//       var theme = Theme.of(context).textTheme;
//       return Container(
//         height: getHeight(70),
//         width: double.infinity,
//         color: bodyBackground,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: getHeight(0.0)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListView.builder(
//                   itemCount: 4,
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           Get.to(navBarScreens[index],transition: Transition.noTransition);
//                           currentIndex = index;
//                         });
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: getWidth(15), vertical: getHeight(12)),
//                         child: NavBarWidget(
//                           index: index,
//                           currentIndex: widget.indexx,
//                           theme: theme,
//                           text: navText[index],
//                           icon: navIcon[index],
//                         ),
//                       ),
//                     );
//                   })
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
//   class NavBarWidget extends StatelessWidget {
//     final index;
//     final IconData icon;
//     final String text;
//
//     const NavBarWidget({
//       Key? key,
//       required this.currentIndex,
//       required this.theme,
//       required this.icon,
//       required this.text,
//       this.index,
//     }) : super(key: key);
//
//     final int currentIndex;
//     final TextTheme theme;
//
//     @override
//     Widget build(BuildContext context) {
//       return Column(
//         children: [
//           Container(
//             width: getWidth(68),
//             height: getHeight(40),
//             decoration: currentIndex == index
//                 ? BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.circular(40),
//                   )
//                 : const BoxDecoration(),
//             child: Icon(
//               icon,
//               size: 30,
//               color:currentIndex == index
//                   ? Colors.white:blackColor,
//             ),
//           ),
//           // SizedBox(
//           //   height: getHeight(6.0),
//           // ),
//           // Text(
//           //   text,
//           //   style: theme.subtitle1,
//           // )
//         ],
//       );
//     }
//   }
