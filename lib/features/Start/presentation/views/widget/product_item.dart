import 'package:flutter/material.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';

import '../../../../../core/utilis/styles/textstyle.dart';
import '../../../../home/data/HomeModel.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.model,
  });
  final Products model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image(
                      image: NetworkImage(model.image ?? ''),
                      height: 200,
                      width: double.infinity,
                    ),
                    model.discount != 0
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.red,
                            child: Text(
                              "DISCOUNT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        : Container(),
                  ],
                  alignment: AlignmentDirectional.bottomStart,
                ),
                Text(
                  model.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Text(
                      "${model.price?.round() ?? 0}",
                      style: Textstyle.defaultstylebold,
                    ),
                    SizedBox(width: 5),
                    model.discount != 0
                        ? Text(
                            "${model.oldPrice?.round() ?? 0}",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          )
                        : Container(),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopcubitCubit.get(context)
                            .ChangeFavorite(product_id: model.id!);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            ShopcubitCubit.get(context).Favourite[model.id] ==
                                    true
                                ? Kprimarycolor
                                : Colors.grey[300],
                        radius: 15,
                        child: Icon(Icons.favorite_border),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
