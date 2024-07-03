import 'package:flutter/material.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';

class DefaultTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String title;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final Icon pref;
  final Color color;
  final bool? obsecure;
  final TextEditingController controller;
  final bool readonly;
  DefaultTextForm(
      {super.key,
      this.validator,
      required this.title,
      required this.controller,
      this.suffix,
      required this.pref,
      this.color = Colors.deepOrange,
      this.obsecure = false,
      this.keyboardType,
      this.readonly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      keyboardType: keyboardType,
      obscureText: obsecure!,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: title,
          suffixIcon: suffix == null ? null : suffix,
          labelStyle: Textstyle.defaultstylenormalBlack,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(16)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.circular(16)),
          prefixIcon: pref,
          fillColor: color,
          focusColor: color,
          prefixIconColor: color,
          suffixIconColor: color,
          iconColor: color),
    );
  }
}
