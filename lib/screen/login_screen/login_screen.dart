import 'package:ex6/configs/constant.dart';
import 'package:ex6/screen/home_screen/home_screen.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_cubit.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/helper_function.dart';
import '../../widgets/dialog/dialog_forget_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  late LoginCubit loginCubit;

  @override
  initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await doAuthenticate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    usernameC.text='thanhphongcao1601';
    passwordC.text='123456';
    return Scaffold(
      body: Container(
        color: const Color(AppColors.darkBlue),
        child: SafeArea(
          child: Container(
            color: const Color(AppColors.darkBlue),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 2 - 50,
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/square_logo.png')),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height / 2,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: usernameC,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Tài khoản không được đê trống';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            labelText: 'Tài khoản',
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(
                                                      AppColors.lightBlue)),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2, color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(
                                                      AppColors.lightBlue)),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: passwordC,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Mật khẩu không được để trống';
                                          } else if (value.length < 4) {
                                            return 'Mật khẩu phải từ 4 kí tự';
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        obscureText: true,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            labelText: 'Mật khẩu',
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(
                                                      AppColors.lightBlue)),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2, color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(
                                                      AppColors.lightBlue)),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ForgetPassword());
                                      },
                                      child: const Text(
                                        'Đặt lại mật khẩu',
                                        style: TextStyle(
                                            color:
                                                Color(AppColors.lightBlue)),
                                      ))),
                            ),
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.login(
                                      context, usernameC.text, passwordC.text);
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color(AppColors.lightGreen),
                                            Color(AppColors.lightBlue)
                                          ]),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: BlocConsumer<LoginCubit, LoginState>(
                                    listener: (context, state) {
                                      if (state is LoginLoaded) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()));
                                      }
                                    },
                                    builder: (context, state) => state
                                            is LoginLoading
                                        ? const SizedBox(
                                            //width: 100,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const SizedBox(
                                            //width: 100,
                                            child: Text(
                                              'Đăng nhập',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(
                                                      AppColors.darkBlue)),
                                            ),
                                          ),
                                  )),
                            ),
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) => state is LoginError
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.alert,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                doAuthenticate(context).then((isLogged) {
                                  if (!isLogged) {
                                    loginCubit.emit(const LoginError(
                                        'Vui lòng đăng nhập để cài đặt khóa bảo mật'));
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
