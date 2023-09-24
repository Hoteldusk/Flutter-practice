# practice 01
## 스타일 분리하려면 MaterialApp 에서 ThemeData 추가
```dart
MaterialApp(
    theme: ThemeData(
        // 이러면 모든 아이콘은 파래진다
        iconTheme: IconThemeData( color:Colors.blue )
    ),
    home: MyApp()
)
```
- 웹개발로 봤을때 `<style></style>` 과 유사하다고 볼수있다

## part2_01
- ThemeData, 스타일을 변수로만들기
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.blue),
        appBarTheme: AppBarTheme(
          color: Colors.grey,
          actionsIconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.red), // Text
          titleMedium: TextStyle(color: Colors.amber), // ListTile
          labelLarge: TextStyle(color: Colors.amberAccent), // button
          titleLarge: TextStyle(color: Colors.black), // headLine6
        ),
      ),
      home: MyApp(),
    ),
  );
}

// Theme안쓰고 변수로 만들어서 스타일을 적용시킬수도 있음
var exTextStyle = TextStyle();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // ThemeData에 디자인 했는데 반영이 안되는 이유
          // ThemeData 사용시 특징
          // 1. 위젯은 나랑 가까운 스타일을 가장 먼저 적용
          // 2. 복잡한 위젯은 복잡한위젯Theme() 안에서 스타일 줘야할수도 있다
          Icon(Icons.star),
        ],
      ),
      body: Column(
        children: [
          Icon(Icons.star),
          Text(
            "안녕",
            style: exTextStyle,
          ),
        ],
      ),
    );
  }
}

```