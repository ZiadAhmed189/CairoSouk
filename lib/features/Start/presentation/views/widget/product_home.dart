import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/features/Start/presentation/views/widget/categories_item.dart';
import 'package:shop_app/features/Start/presentation/views/widget/product_item.dart';

import '../../../../home/data/CategoriesModel.dart';
import '../../../../home/data/HomeModel.dart';
import '../../../../view_product/views/view_product.dart';

class ProductHome extends StatelessWidget {
  const ProductHome({
    super.key,
    required this.model,
    required this.catmodel,
  });
  final DataHome model;
  final DataCategories catmodel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.banners!
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 100,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              Categories_Item(mdoel: catmodel.data![index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 5,
                              ),
                          itemCount: catmodel.data!.length)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    model.products!.length,
                    (index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProduct(
                                          model: model.products![index],
                                        )));
                          },
                          child: ProductItem(
                            model: model.products![index],
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
