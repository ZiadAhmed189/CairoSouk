import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/core/Api/api_service.dart';
import 'package:shop_app/features/Categories/presentation/views/CategoriesScreen.dart';
import 'package:shop_app/features/Favorite/presentation/views/FavoriteScreen.dart';
import 'package:shop_app/features/Start/presentation/views/StartScreen.dart';
import 'package:shop_app/features/home/data/HomeModel.dart';

import '../../data/CategoriesModel.dart';
import '../../data/FavoriteModel.dart';

part 'shopcubit_state.dart';

class ShopcubitCubit extends Cubit<ShopcubitState> {
  ShopcubitCubit() : super(ShopcubitInitial());
  static ShopcubitCubit get(context) => BlocProvider.of(context);
  int indexscreen = 0;
  List<Widget> ScreenBody = [
    StartScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
  ];
  void change_index_screen(int ind) {
    indexscreen = ind;
    emit(Changeindexbottom());
  }

  Map<int, bool> Favourite = {};
  Home_Model? home_model;
  void GetHome() async {
    emit(GetHomeLoadingState());
    await DioHelper.getData(
      url: 'https://student.valuxapps.com/api/home',
    ).then((value) {
      print(value.data);
      print(value.statusCode);
      home_model = Home_Model.fromJson(value.data);
      home_model!.data!.products!.forEach((element) {
        Favourite.addAll({element.id!: element.inFavorites!});
      });
      emit(GetHomeSuccessState());
    }).catchError((error) {
      print("error : ${error}");
      emit(GetHomeFailureState(error: error));
    });
  }

  CategoriesModel? categoriesModel;
  void GetCategories() async {
    emit(GetCategoriesLoadingState());
    await DioHelper.getData(
      url: 'https://student.valuxapps.com/api/categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print("error Cat : ${error}");
      emit(GetCategoriesFailureState(error: error));
    });
  }

  void ChangeFavorite({
    required int product_id,
  }) {
    Favourite[product_id] = !Favourite[product_id]!;
    emit(ChangeFavoriteiconSuccessState());
    DioHelper.postData(
            url: 'https://student.valuxapps.com/api/favorites',
            data: {
              'product_id': product_id,
            },
            token: token)
        .then((value) {
      if (!value.data["status"]) {
        Favourite[product_id] = !Favourite[product_id]!;
      }
      print(value.data);
      emit(ChangeFavoriteSuccessState(
          status: value.data["status"], message: value.data["message"]));
    }).catchError((error) {
      Favourite[product_id] = !Favourite[product_id]!;
      emit(ChangeFavoriteFailureState(error: error));
      print(error);
    });
  }

  Favorite_Model? favorite_model;
  void GetFavorite() async {
    emit(GetFavoriteLoadingState());
    await DioHelper.getData(
            url: 'https://student.valuxapps.com/api/favorites', token: token)
        .then((value) {
      favorite_model = Favorite_Model.fromJson(value.data);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print("error Cat : ${error}");
      emit(GetFavoriteFailureState(error: error));
    });
  }
}
