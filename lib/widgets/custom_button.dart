
import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import 'package:pet_appoinment_app/values/size_config.dart';

import '../../values/my_colors.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  void Function() onPressed;
  final bool? gradientt;
  final FontWeight? fontWeight;

  CustomButton(
      {this.height,
        this.width,
        required this.text,
        this.fontSize,
        this.borderColor,
        this.textColor,
        this.roundCorner,
        this.color,
        required this.onPressed,
        Key? key,
        this.gradientt,
        this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: height ?? getHeight(52),
      width: width ?? getWidth(334),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundCorner ?? getHeight(10)),
          color: color ?? primaryColor,
          border: borderColor != null ? Border.all(color: borderColor!) : null),
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(roundCorner ?? 30),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textColor == null
              ? kSize20WhiteW400Text
              : kSize20WhiteW400Text.copyWith(color: textColor),
        ),
      ),
    );
  }
}
