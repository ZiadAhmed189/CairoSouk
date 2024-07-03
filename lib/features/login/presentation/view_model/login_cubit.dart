import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/core/Api/api_service.dart';

import '../../data/Login_Model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool obsecure = false;
  void changeicon() {
    obsecure = !obsecure;
    emit(changeiconstate());
  }

  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    DioHelper.postData(
      url: 'https://student.valuxapps.com/api/login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        loginModel = LoginModel.fromJson(value.data);
        print(loginModel!.message);
        emit(LoginSuccess(loginModel: loginModel!));
      } else {
        if (value.statusCode == 401) {
          emit(LoginFauilre(error: value.data["message"]));
        } else {
          emit(LoginFauilre(error: value.data["message"]));
        }
      }
    }).catchError((error) {
      log(error.toString());
      emit(LoginFauilre(error: error));
    });
  }
}
