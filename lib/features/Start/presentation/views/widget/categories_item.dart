import 'package:flutter/material.dart';

import '../../../../home/data/CategoriesModel.dart';

Stack Categories_Item({required Data mdoel}) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage("${mdoel.image}"),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
          width: 100,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            textAlign: TextAlign.center,
            "${mdoel.name}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Cairo",
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
    ],
  );
}
