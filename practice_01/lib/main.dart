import 'package:flutter/material.dart';

void main() {
  // app 을 시작하라
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: ShopItem(),
      ),
    );
  }
}

/// 위젯 분리방법
/// class 작명 stless
/// return 옆에 축약할 레이아웃 넣기
class ShopItem extends StatelessWidget {
  const ShopItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text("안녕"),
    );
  }
}

// 변수로도 축약가능
var a = SizedBox(
  child: Text("안녕"),
);
