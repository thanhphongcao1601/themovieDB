import 'package:flutter/material.dart';

Text buildTextMainTitle({String? text}) {
  text ??= 'textMainTitle';
  return Text(
    text,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}

Text buildTextSubTitle({String? text}) {
  text ??= 'textSubtitle';
  return Text(
    text,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );
}

Widget buildTitleSlideBar({String? title}) {
  title ??= 'textTitleSlideBar';
  return Row(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff1DD4AC), Color(0xff02B5E0)])),
          height: 35,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Color(0xff032541)),
          ),
        ),
      ),
    ],
  );
}

Widget buildSubTitleSlideBar({String? title}){
  title ??= 'textSubTitleSlideBar';
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 25, top: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white, Color(0xff02B5E0)]),
              borderRadius: BorderRadius.circular(50),
            ),
            height: 30,
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Color(0xff032541)),
            ),
          ),
        ),
      ],
    );
}