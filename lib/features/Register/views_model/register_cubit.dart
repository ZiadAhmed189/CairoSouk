import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/Api/api_service.dart';
import '../../login/data/Login_Model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? registermodel;
  void UserRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'https://student.valuxapps.com/api/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        registermodel = LoginModel.fromJson(value.data);
        print(registermodel!.message);
        emit(RegisterSuccessState(loginModel: registermodel!));
      } else {
        if (value.statusCode == 401) {
          emit(RegisterFauilreState(error: value.data["message"]));
        } else {
          emit(RegisterFauilreState(error: value.data["message"]));
        }
      }
    }).catchError((error) {
      log(error.toString());
      emit(RegisterFauilreState(error: error));
    });
  }

  bool obsecure = false;
  void changeicon() {
    obsecure = !obsecure;
    emit(changeiconstate());
  }
}
