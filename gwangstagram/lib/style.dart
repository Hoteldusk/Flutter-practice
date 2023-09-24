import 'package:flutter/material.dart';

// 스타일을 변수형태로 저장
var theme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 1, // 그림자 크기
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    // 아이콘 버튼에도 적용됨
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 40,
    ),
  ),

  // textTheme: TextTheme(
  //   bodyMedium: TextStyle(
  //     fontWeight: FontWeight.bold,
  //   ),
  // ),

  // textButtonTheme: TextButtonThemeData(
  //     // TextButton 스타일주려면 styleForm사용
  //     style: TextButton.styleFrom(
  //   backgroundColor: Colors.grey,
  // )),
);
