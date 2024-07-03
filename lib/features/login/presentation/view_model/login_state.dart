part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class changeiconstate extends LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

class LoginFauilre extends LoginState {
  final String error;

  LoginFauilre({required this.error});
}
