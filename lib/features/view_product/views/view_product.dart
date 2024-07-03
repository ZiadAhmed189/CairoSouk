import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../core/utilis/styles/textstyle.dart';
import '../../home/data/HomeModel.dart';

class ViewProduct extends StatefulWidget {
  final Products model;

  const ViewProduct({super.key, required this.model});

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cairo Souk",
          style: Textstyle.defaultstyleboldBlack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.name!,
                  style: Textstyle.defaultstylebold,
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.grey[300],
                  child: CarouselSlider(
                    items: widget.model.images!
                        .map((image) => camera(image))
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1,
                      initialPage: 0,
                      scrollDirection: Axis.horizontal,
                      reverse: false,
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "EGP",
                      style: Textstyle.defaultstylebold,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "${widget.model.price}",
                      style: Textstyle.defaultstyleboldBlack,
                    ),
                    SizedBox(width: 3),
                    widget.model.discount != 0
                        ? Text(
                            "${widget.model.oldPrice}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isExpanded
                          ? widget.model.description!
                          : widget.model.description!.substring(
                                  0,
                                  widget.model.description!.length > 100
                                      ? 100
                                      : widget.model.description!.length) +
                              (widget.model.description!.length > 100
                                  ? "..."
                                  : ""),
                      maxLines: isExpanded ? null : 3,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? "Show Less" : "More",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget camera(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
