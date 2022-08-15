import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/app/app_cubit.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/repository/user_repo.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_cubit.dart';
import 'package:ex6/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late APIClient apiClient;
  late UserRequest userRepo;

  @override
  initState() {
    super.initState();
    apiClient = APIClient();
    userRepo = UserRequest(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(apiClient),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Themoviedb',
          home: AnimatedSplashScreen(
              nextScreen: BlocProvider(
                  create: (_) => LoginCubit(userRepo), child: const Login()),
              duration: 3000,
              splash: Image.asset('assets/images/square_logo.png'),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: const Color(AppColors.darkBlue))),
    );
  }
}
