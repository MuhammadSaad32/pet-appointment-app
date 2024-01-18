// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dimens.dart';
// import 'my_colors.dart';
//
// class Styles {
//   static final appTheme = _baseTheme.copyWith(
//     iconTheme: const IconThemeData(
//       color: black,
//       size: Dimens.size20,
//     ),
//     textTheme: _baseTextTheme,
//     cardTheme: _baseTheme.cardTheme.copyWith(
//       margin: EdgeInsets.zero,
//     ),
//     textSelectionTheme: _baseTheme.textSelectionTheme.copyWith(
//       cursorColor: _colorScheme.secondary,
//       selectionHandleColor: _colorScheme.secondary,
//     ),
//     appBarTheme: AppBarTheme(
//         systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: primaryColor,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light
//         ),
//         backgroundColor: _colorScheme.primary,
//         titleTextStyle:  TextStyle(
//           fontSize: 18,
//          // fontWeight: FontWeight.bold,
//           fontStyle: FontStyle.normal,
//           fontFamily: "Poppins",
//         )),
//     scrollbarTheme: ScrollbarThemeData(
//         isAlwaysShown: true,
//         showTrackOnHover: true,
//         interactive: true,
//         trackColor: MaterialStateProperty.all(green100),
//         trackBorderColor: MaterialStateProperty.all(yellow),
//         thickness: MaterialStateProperty.all(5),
//         thumbColor: MaterialStateProperty.all(darkBlue),
//         radius: const Radius.circular(10),
//         minThumbLength: 10),
//   );
//
//   static final secondaryTextTheme = _baseTextTheme.apply(
//     displayColor: bodyBackground,
//     bodyColor: white200,
//   );
//
//   static final onSecondaryTextTheme = _baseTextTheme.apply(
//     displayColor: black,
//     bodyColor: black,
//   );
//
//   static const _colorScheme = ColorScheme.light(
//     primary: primaryColor,
//     secondary: black,
//     onPrimary: bodyBackground,
//     onSecondary: parpal,
//     onBackground: appBackground,
//   );
//
//   static final _baseTheme = ThemeData.from(
//     colorScheme: _colorScheme,
//     textTheme: Typography.material2018().black.apply(
//           fontFamily: "Poppins",
//           displayColor: _colorScheme.secondary,
//           bodyColor: _colorScheme.secondary,
//         ),
//   );
//
//   static final _baseTextTheme = _baseTheme.textTheme.copyWith(
//     headline1: _baseTheme.textTheme.headline1!.copyWith(
//       color: black,
//       fontSize: 22,
//       height: 1.5,
//       fontFamily: "Poppins",
//       fontWeight: FontWeight.w700,
//     ),
//     headline2: _baseTheme.textTheme.headline2!.copyWith(
//       color: textColor,
//       fontSize: 20,
//       height: 1.5,
//       fontFamily: "Poppins",
//       fontStyle: FontStyle.normal,
//
//     ),
//     headline3: _baseTheme.textTheme.headline3!.copyWith(
//       fontSize: 18,
//       color: appBarTextColor,
//       height: 1.5,
//       fontFamily: "Poppins",
//         fontWeight: FontWeight.w700,
//       fontStyle: FontStyle.normal
//     ),
//     headline4: _baseTheme.textTheme.headline4!.copyWith(
//       color: textColor,
//       fontSize: 16,
//       height: 1.5,
//       fontStyle: FontStyle.normal,
//       fontFamily: "Poppins",
//       fontWeight: FontWeight.w500,
//     ),
//     headline5: _baseTheme.textTheme.headline5!.copyWith(
//       fontSize: 14,
//       color: textColor,
//       height: 1.5,
//       fontFamily: "Poppins",
//       fontStyle: FontStyle.normal,
//       fontWeight: FontWeight.w400,
//     ),
//     headline6: _baseTheme.textTheme.headline6!.copyWith(
//       fontSize: 12,
//       color: black,
//       height: 1.5,
//       fontFamily: "Poppins",
//       fontWeight: FontWeight.w400,
//     ),
//     bodyText1: _baseTheme.textTheme.bodyText1!.copyWith(
//         fontSize: 16,
//         color: textColor,
//         height: 1.5,
//         fontFamily: "Poppins",
//        ),
//     bodyText2: _baseTheme.textTheme.bodyText2!.copyWith(
//         fontSize: 14,
//         color: textColor,
//         height: 1.5,
//         fontFamily: "Poppins",
//         fontStyle: FontStyle.normal ),
//     subtitle1: _baseTheme.textTheme.subtitle1!.copyWith(
//         fontSize: 12,
//         color: black,
//         height: 1.5,
//         fontFamily: "Poppins",
//         fontWeight: FontWeight.w700
//     ),
//     subtitle2: _baseTheme.textTheme.subtitle2!.copyWith(
//         fontSize: 12,
//         color: black,
//         //  decoration: TextDecoration.underline,
//         height: 1.5,
//         fontFamily: "Poppins",
//         fontWeight: FontWeight.normal),
//     caption: _baseTheme.textTheme.caption!.copyWith(
//       fontSize: 12,
//       color: grey,
//       height: 1.5,
//       fontFamily: "Poppins",
//     ),
//     overline: _baseTheme.textTheme.overline!.copyWith(
//       fontSize: 8,
//       fontFamily: "Poppins",
//       color: grey,
//       height: 1.5,
//     ),
//   );
//
//   static final _accentTextTheme = _baseTextTheme.apply(
//     displayColor: _colorScheme.secondary,
//     bodyColor: _colorScheme.secondary,
//   );
//
//   Styles._();
// }
