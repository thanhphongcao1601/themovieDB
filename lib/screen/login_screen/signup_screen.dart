import 'package:ex6/configs/constant.dart';
import 'package:flutter/material.dart';
import '../../widgets/dialog/dialog_forget_password.dart';
import 'login_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Logo
                        Container(
                            height: MediaQuery.of(context).size.height / 3 - 50,
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/square_logo.png')),
                        Container(
                          height: MediaQuery.of(context).size.height / 3 * 2,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //Tai khoan
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Tài khoản',
                                      labelStyle: const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(AppColors.lightBlue)),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              //Mat khau
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Mật khẩu',
                                      labelStyle: const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(AppColors.lightBlue)),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              //Nhap lai mat khau
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Nhập lại mật khẩu',
                                      labelStyle: const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(AppColors.lightBlue)),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              //Email
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(AppColors.lightBlue)),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              //Dat lai mat khau
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => const ForgetPassword());
                                        },
                                        child: const Text(
                                          'Đặt lại mật khẩu',
                                          style:
                                              TextStyle(color: Color(AppColors.lightBlue)),
                                        ))),
                              ),
                              //btn Dang nhap
                              Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color(AppColors.lightGreen),
                                            Color(AppColors.lightBlue)
                                          ]),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 20)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Đăng ký',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(AppColors.darkBlue)),
                                    ),
                                  )),
                              const SizedBox(
                                height: 20
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Đã có tài khoản? Vào',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Login()));
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(' đây '),
                                  ),
                                  const Text('để đăng nhập',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ],
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


