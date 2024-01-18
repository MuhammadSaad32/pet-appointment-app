import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_appoinment_app/values/size_config.dart';

import '../values/values.dart';

class CustomTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final Color? bordercolor;
  final Color? background;
  final String text;
  final int length;
  final int? verticalPadding;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatters;
  bool? Readonly = false;
  final Widget? icon;
  final suffixIcon;
  final InputBorder? border;
  final String? errorText;
  final FocusNode? focusNode;
  final String? suffixtext;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final int? maxlines;
  final Color? color;
  bool? obscureText;
  final AutovalidateMode? autovalidateMode;

  // final bool? isObscure;
  final Function(String)? onFieldSubmitted;

  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;

  CustomTextField({
    Key? key,
    this.height,
    this.width,
    this.roundCorner,
    this.suffixIcon,
    this.bordercolor,
    this.background,
    this.controller,
    this.border,
    this.maxlines,
    required this.text,
    this.validator,
    this.onChanged,
    this.errorText,
    this.Readonly,
    this.focusNode,
    this.hintColor,
    this.icon,
    this.color,
    this.obscureText,
    this.suffixtext,
    required this.length,
    required this.keyboardType,
    required this.inputFormatters,
    // this.isObscure,
    this.textColor,
    this.cursorColor,
    this.onFieldSubmitted,
    this.verticalPadding,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: widget.height ?? getHeight(72),
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
          color: widget.background ?? Colors.transparent,
          borderRadius: BorderRadius.circular(widget.roundCorner ?? 48)),
      child: TextFormField(
        // autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        obscuringCharacter: '*',
        maxLength: widget.length,
        cursorHeight: 20,
        maxLines: widget.maxlines ?? 1,
        focusNode: widget.focusNode,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return widget.errorText ?? 'Please enter some text';
              }
              return null;
            },
        style: TextStyle(
            color: widget.textColor ?? widget.textColor,
            fontSize: getFont(16),
            fontWeight: FontWeight.w400),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.start,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: widget.cursorColor ?? primaryColor,
        inputFormatters: <TextInputFormatter>[widget.inputFormatters],
        textInputAction: TextInputAction.next,
        // readOnly: true,
        readOnly: widget.Readonly == true ? true : false,
        obscureText: widget.obscureText ?? false,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getWidth(10), vertical: getHeight(16)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getHeight(8),
            ),
            borderSide: BorderSide(
              color: blackColor.withOpacity(0.6),
            ),
          ),
          errorText: widget.errorText,

          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getHeight(8),
            ),
            borderSide: BorderSide(
              color: blackColor.withOpacity(0.6),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getHeight(8),
            ),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),

          errorBorder: OutlineInputBorder(
            gapPadding: 22,
            borderRadius: widget.roundCorner == null
                ? BorderRadius.circular(getHeight(8))
                : BorderRadius.circular(widget.roundCorner!),
            borderSide: BorderSide(
              color: red500,
            ),
          ),
          hintText: widget.text.tr,
          // suffixIcon: suffixIcon,
          suffixIcon: (widget.suffixIcon != null)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText!;
                    });
                  },
                  child: Icon(
                    widget.obscureText!
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: getHeight(20),
                  ))
              : null,
          // errorText: widget.errorText,
          errorStyle: TextStyle(fontSize: 8),
          hintStyle: TextStyle(
              color: widget.hintColor ?? hintText,
              fontWeight: FontWeight.normal,
              fontSize: getFont(14)),
          // contentPadding: EdgeInsets.only(left: 15, top: 9),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: EdgeInsets.all(13),
                  child: widget.icon,
                )
              : null,
          // errorStyle: TextStyle(fontSize: 0),
          suffixText: widget.suffixtext,
          focusColor: primaryColor,
        ),
      ),
    );
  }
}
