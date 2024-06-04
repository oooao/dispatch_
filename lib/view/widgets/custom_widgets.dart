import 'package:dispatch/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hinttext;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle labelStyle;

  const CustomTextField({
    Key? key,
    this.height,
    this.width,
    this.labelText,
    this.labelStyle = const TextStyle(fontSize: 13, color: Colors.black),
    this.hinttext,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.maxLines = 1,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (labelText != null)
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 35.w),
              child: Text(labelText!, style: labelStyle),
            ),
          Container(
            height: 33.h,
            width: 200.w,
            child: TextFormField(
              style: TextStyle(fontSize: 14, fontFamily: 'MicrosoftYaHei'),
              obscureText: obscureText,
              keyboardType: keyboardType,
              controller: controller,
              readOnly: readOnly,
              onEditingComplete: onEditingComplete,
              maxLines: maxLines,
              onTap: onTap,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Colors.black26,
                    width: 1,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: Colors.black26,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: primaryTextColor,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    color: primaryTextColor,
                    width: 1,
                  ),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Image.asset('assets/images/lines.png'),
                ),
                suffixIcon: suffixIcon,
                hintText: hinttext,
                hintStyle: context.textTheme.bodyLarge!.copyWith(
                    //fontWeight: FontWeight.normal,
                    letterSpacing: 3.sp,
                    fontSize: 13,
                    fontFamily: 'MicrosoftYaHei',
                    color: Colors.black38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
