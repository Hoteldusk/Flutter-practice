import 'package:flutter/material.dart';

void main() {
  // app 을 시작하라
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var title = "Contract";
  var numb;
  var names = ["가가가", "나나나", "다다다"];

  @override
  void initState() {
    super.initState();
    numb = names.length;
  }

  nameListAdd(text) {
    print("text : $text");
    if (text == "") {
      return false;
    }
    setState(() {
      names.add(text);
    });
  }

  numberAdd() {
    setState(() {
      numb = names.length;
    });
  }

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

                // 자식 widget에게 state 전송하는 법
                // 1. 전달
                // (전송할변수이름 : 전송할 값)

                // 2. 등록
                // 그 후 자식 widget에 가서 생성자에 변수이름 기재, final 로 변수선언

                // 3. 사용
                // 자식위젯에서 변수가지고 사용하면됨 단, 부모가 보낸 state는 변경안하는것을 권장, final로 선언
                return MyDialog(
                  title: title,
                  numberAdd: numberAdd,
                  nameListAdd: nameListAdd,
                );
              },
            );
          },
        );
      }),
      appBar: AppBar(
        title: Text(numb.toString()),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                names.sort();
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[300])),
            child: Text("정렬"),
          ),
        ],
      ),
      body: ListView.builder(
        // Dialog() 쓰면 그냥 나옴
        itemCount: names.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 50,
              color: Colors.black,
            ),
            title: Text(names[i]),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  // 리스트에서 특정인덱스 제거
                  names.removeAt(i);
                  numb = names.length;
                });
              },
              child: Text("삭제"),
            ),
          );
        },
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({
    super.key,
    this.title,
    this.numberAdd,
    this.nameListAdd,
  });
  final title;
  final numberAdd;
  final nameListAdd;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  // var inputData = TextEditingController();
  var localInputText = "";

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
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              // 웹개발 처럼 onChanged 사용가능 사용자가 입력한 값 : text, 값이 바뀔때 마다 실행이됨
              // onChanged: (text) {},
              onChanged: (text) {
                localInputText = text;
              },
            ),
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
                      widget.nameListAdd(localInputText);
                      widget.numberAdd();
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
