import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utilis/components/Loading.dart';
import 'package:shop_app/features/Categories/presentation/views/widgets/CategoriesWidget.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopcubitCubit, ShopcubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopcubitCubit.get(context);
        var categoriesData = cubit.categoriesModel?.data?.data;

        return ConditionalBuilder(
          condition: categoriesData != null,
          fallback: (context) => Loading(),
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => CategoriesPage(
              model: categoriesData![index],
            ),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
              endIndent: 20,
              indent: 20,
            ),
            itemCount: categoriesData!.length,
          ),
        );
      },
    );
  }
}
