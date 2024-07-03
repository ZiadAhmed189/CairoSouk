import 'package:flutter/material.dart';

import '../../../../home/data/CategoriesModel.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({
    super.key,
    required this.model,
  });
  final Data model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage("${model.image}"),
            height: 120,
            width: 120,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "${model.name}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "Cairo",
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
