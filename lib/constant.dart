import 'package:flutter/material.dart';

import 'core/Api/cache_helper.dart';

String Kprimaryfont = "Cairo";
Color Kprimarycolor = Colors.deepOrange;
dynamic? OnBoarding;
String? token;

void Signout(context) {
  TextButton(
    onPressed: () {
      CacheHelper.removeData(key: "token").then((value) {
        Navigator.pop(context);
      });
      print(token);
    },
    child: Text("SIGNOUT"),
  );
}
