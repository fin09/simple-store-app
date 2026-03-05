import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextF extends StatelessWidget {
  const CustomTextF({
    super.key,
    required this.text,
    this.onChanged,
    this.obscureText = false,
    required TextInputType inputType,
  });
  final String text;
  final Function(String)? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(fontSize: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }
}
