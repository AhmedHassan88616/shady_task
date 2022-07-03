part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserDataLoadingState extends UserState {}

class GetUserDataSuccessState extends UserState {}

class GetUserDataErrorState extends UserState {}
