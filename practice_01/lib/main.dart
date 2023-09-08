import 'package:flutter/material.dart';

void main() {
  // app 을 시작하라
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var name = ["가가가", "나나나", "다다다"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: () {},
            );
          },
        ),
        appBar: AppBar(),
        body: ListView.builder(
            // Dialog() 쓰면 그냥 나옴
            itemCount: name.length,
            itemBuilder: (c, i) {
              return ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.black,
                ),
                title: Text(name[i]),
              );
            }),
      ),
    );
  }
}
