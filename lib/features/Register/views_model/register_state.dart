part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class changeiconstate extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final LoginModel loginModel;

  RegisterSuccessState({required this.loginModel});
}

class RegisterFauilreState extends RegisterState {
  final String error;

  RegisterFauilreState({required this.error});
}
