import 'package:dio/dio.dart';
import 'package:ex6/local_data/data_home.dart';
import 'package:ex6/repository/user_repo.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.userRepo) : super(const LoginInitial());
  final UserRequest userRepo;

  login(BuildContext context, String username, String password) async {
    emit(const LoginLoading());
    var t = await userRepo.requestToken();
    print(t);

    final prefs = await SharedPreferences.getInstance();
    userRepo.requestToken().then((newToken) => userRepo
            .requestTokenWithUsernameAndPassword(username, password, newToken)
            .then((isLoginSuccess) async {
          //dang nhap thanh cong
          if (isLoginSuccess) {
            //luu cac thong tin cua tai khoan khi dang nhap
            currentUsername = username;
            await prefs.setString('currentUsername', username);
            await prefs.setString('currentToken', newToken);
            //luu trang thai da dang nhap
            await prefs.setBool('isLoggedIn', true);

            emit(const LoginLoaded());
          } else {
            emit(const LoginError('Tài khoản và mật khẩu không đúng'));
          }
        }));
    print('abc');
  }
}
