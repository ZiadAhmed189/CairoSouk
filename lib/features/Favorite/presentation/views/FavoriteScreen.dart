import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utilis/components/Loading.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';

import '../../../../core/utilis/styles/textstyle.dart';
import '../../../home/data/FavoriteModel.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopcubitCubit()..GetFavorite(),
      child: BlocConsumer<ShopcubitCubit, ShopcubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          var favoriteModel = ShopcubitCubit.get(context).favorite_model;
          return ConditionalBuilder(
            fallback: (context) => Loading(),
            condition:
                state is! GetFavoriteLoadingState && favoriteModel != null,
            builder: (context) {
              if (favoriteModel == null ||
                  favoriteModel.data == null ||
                  favoriteModel.data!.data == null) {
                return Center(child: Text("No favorites found."));
              }
              return ListView.separated(
                itemBuilder: (context, index) =>
                    FavoriteItem(model: favoriteModel.data!.data![index]),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                itemCount: favoriteModel.data!.data!.length,
              );
            },
          );
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final DataPro model;

  const FavoriteItem({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${model.product?.image ?? ''}"),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              if (model.product?.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.product?.name ?? ''}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.product?.price ?? ''}",
                      style: Textstyle.defaultstylebold,
                    ),
                    SizedBox(width: 5),
                    if (model.product?.discount != 0)
                      Text(
                        "${model.product?.oldPrice ?? ''}",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
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
