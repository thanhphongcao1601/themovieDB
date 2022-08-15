import 'dart:async';
import 'package:ex6/local_data/data_home.dart';
import 'package:ex6/screen/home_screen/home_screen.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_cubit.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: constant_identifier_names
enum MediaType { MOVIE, TV, PERSON }

void goToPageUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

String getShortDate(String day, int length){
  if (day.length>=length){
    return day.substring(0,length);
  }
  return day;
}

Future<bool> doAuthenticate(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  //Lay local_data tu phien dang nhap truoc
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isAuthenticate = prefs.getBool('isAuthenticate') ?? false;
  currentAuthenticate = isAuthenticate;
  currentUsername = prefs.getString('currentUsername') ?? '';

  final LocalAuthentication auth = LocalAuthentication();
  //kiem tra thiet bi co ho tro van tay
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await auth.isDeviceSupported();

  if (isLoggedIn &&
      isAuthenticate &&
      canAuthenticate &&
      canAuthenticateWithBiometrics) {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
      if (didAuthenticate) {
        context.read<LoginCubit>().emit(const LoginLoading());
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
        return true;
      }
    } on PlatformException {
      if (kDebugMode) {
        print('error');
      }
    }
  } else {
    return false;
  }
  return true;
}


