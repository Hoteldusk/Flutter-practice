# practice02
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My app"),
          backgroundColor: Colors.amber,
          // appBar 안에 들어가는 것들)
          // title : 왼쪽제목
          // leading : 왼쪽에 넣을 아이콘
          leading: Icon(Icons.star),
          actions: const [
            Icon(Icons.face),
            Icon(Icons.face),
          ],
        ),
        body: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: TextButton(
            child: Text("안녕"),
            onPressed: () {},
          ),
          // 버튼 종류 3개 TextButton, IconButton, ElevatedButton
          // 스타일 줄때는 ButtonStyle
        ),
      ),
    );
  }
}


```