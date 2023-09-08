# 연습 1
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// MateriaApp 쓰면 구글이 제공하는 위젯 사용가능, 기타 설정도 자동으로 설정됨
    return MaterialApp(
      /// 글자 : Text
      /// 아이콘 : Icon(Icons.아이콘이름)
      /// 이미지 : Image.asset("경로"), pubspec.yaml에다가 등록해야됨
      ///
      // home: Container(
      //   /// 사이즈 는 LP, 50LP 는 1.2cm
      //   /// 박스가 꽉차는 이유는 어디서부터 50차지할지 몰라서 그럼
      //   width: 50,
      //   height: 50,
      //   color: Colors.blue,
      // ),

      // Center : 내자식 위젯의 기준점을 중앙으로 설정
      // home: Center(
      //   child: Container(
      //     width: 50,
      //     height: 50,
      //     color: Colors.blue,
      // ),

      /// Scaffold : 상중하로 나눠주는 위젯
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyApp"),
        ),
        body: Text("hello"),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.phone,
                ),
                Icon(
                  Icons.chat,
                ),
                Icon(
                  Icons.account_box,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```