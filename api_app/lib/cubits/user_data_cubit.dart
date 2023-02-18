import 'package:api_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  void onLoad(User user) {
    emit(UserData(user));
  }
}

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserData extends UserDataState {
  late User user;

  UserData(this.user);
}
