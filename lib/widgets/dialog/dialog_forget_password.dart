import 'package:ex6/configs/constant.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: const Text(
        'Quên mật khẩu',
        style: TextStyle(color: Color(AppColors.darkBlue)),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: const TextStyle(color: Color(AppColors.darkBlue)),
          decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: Color(AppColors.darkBlue)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Color(AppColors.darkBlue)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Color(AppColors.lightBlue)),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      contentPadding:
          const EdgeInsets.only(bottom: 0, top: 10, left: 10, right: 10),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel',style: TextStyle(color: Color(AppColors.lightBlue)),),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK',style: TextStyle(color: Color(AppColors.lightBlue)),)
        ),
      ],
    );
  }
}
