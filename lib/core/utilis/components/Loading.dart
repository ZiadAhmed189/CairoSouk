import 'package:flutter/material.dart';
import 'package:shop_app/constant.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Kprimarycolor,
    ));
  }
}
