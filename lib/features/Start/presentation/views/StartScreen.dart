import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utilis/styles/custom_flutter_toast.dart';
import 'package:shop_app/features/Start/presentation/views/widget/product_home.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';

import '../../../../core/utilis/components/Loading.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopcubitCubit, ShopcubitState>(
      listener: (context, state) {
        if (state is ChangeFavoriteSuccessState) {
          if (!state.status) {
            showToast(text: state.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopcubitCubit.get(context);
        var homeModelData = cubit.home_model?.data;
        var categoriesModelData = cubit.categoriesModel?.data;
        return ConditionalBuilder(
          condition: state is! GetHomeLoadingState &&
              state is! GetCategoriesLoadingState &&
              homeModelData != null &&
              categoriesModelData != null,
          builder: (context) => ProductHome(
            model: homeModelData!,
            catmodel: categoriesModelData!,
          ),
          fallback: (context) => Loading(),
        );
      },
    );
  }
}
