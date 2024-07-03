part of 'shopcubit_cubit.dart';

@immutable
abstract class ShopcubitState {}

class ShopcubitInitial extends ShopcubitState {}

class Changeindexbottom extends ShopcubitState {}

class GetHomeLoadingState extends ShopcubitState {}

class GetHomeSuccessState extends ShopcubitState {}

class GetHomeFailureState extends ShopcubitState {
  final dynamic error;

  GetHomeFailureState({required this.error});
}

class GetCategoriesLoadingState extends ShopcubitState {}

class GetCategoriesSuccessState extends ShopcubitState {}

class GetCategoriesFailureState extends ShopcubitState {
  final dynamic error;

  GetCategoriesFailureState({required this.error});
}

class ChangeFavoriteiconSuccessState extends ShopcubitState {}

class ChangeFavoriteSuccessState extends ShopcubitState {
  final String message;
  final bool status;

  ChangeFavoriteSuccessState({required this.message, required this.status});
}

class ChangeFavoriteFailureState extends ShopcubitState {
  final dynamic error;

  ChangeFavoriteFailureState({required this.error});
}

class GetFavoriteLoadingState extends ShopcubitState {}

class GetFavoriteSuccessState extends ShopcubitState {}

class GetFavoriteFailureState extends ShopcubitState {
  final dynamic error;

  GetFavoriteFailureState({required this.error});
}
