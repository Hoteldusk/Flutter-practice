import 'package:flutter/material.dart';

void main() {
  // app 을 시작하라
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
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
    // 여기서 context는 Scaffold 의 부모위젯 => MaterialApp
    // showDialog(), Scaffold.of(), Navigator.pop(), Theme.of() 를사용할때 파라미터에 context가 들어감
    // 이때 위 함수들은 context 내에 MaterialApp 이들어가야함
    // MaterialApp 을 분리해놓지 않으면 context에는 아무정보도 들어가지 않았으므로 함수가 정상적으로 동작하지 않음

    return Scaffold(
      floatingActionButton: Builder(builder: (jokbo) {
        // 중간에 builder로 감싸면 context를 만들어줌
        return FloatingActionButton(
          onPressed: () {
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            showDialog(
              context: context,
              builder: (jokbo) {
                // 이러면 안뜸
                // 해결방법 : MaterialApp() 을 바깥으로 보내면됨

                return MyDialog();
              },
            );
          },
        );
      }),
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
        },
      ),
    );
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Contact",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
