import 'package:flutter/material.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.color = Colors.deepOrange})
      : super(key: key);
  final String title;
  final void Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        height: 50,
        width: double.infinity,
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: onPressed,
          child: Text(
            title,
            style:
                Textstyle.defaultstylenormalBlack.copyWith(color: Colors.white),
          ),
        ));
  }
}
