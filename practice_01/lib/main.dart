import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  // 권한요청을 위한 함수
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      //연락처 권한줬는지 여부
      print("허락됨");
      // 연락처 꺼내는 코드 (await 권장)
      var contacts = await ContactsService.getContacts();
      // print(contacts);
      // [Instance of 'Contact', Instance of 'Contact'] 이런식으로 뜸 첫째 연락처, 둘째 연락처
      print(contacts[0].familyName); //성   출력
      print(contacts[0].givenName); //이름 출력
      print(contacts[0].displayName); // 전체 이름 출력
      print(contacts[1].displayName);
      print(contacts[0].phones?[0].value);
      // 연락처 추가하는 법
      // var newPerson = Contact(); // new 키워드 생략
      // newPerson.givenName = '라에몽';
      // newPerson.givenName = '도';
      // await ContactsService.addContact(newPerson); //휴대폰 연락처에 newPserson 정보가 들어감

      // 연락처 받아오기
      // data = contacts;
      // state 변경은 setState() 안에
      // type 에러 가남 dart는 type을 타입을 잘 지켜야함
      // 해결책 1 : 타입 캐스팅 : 변수하나에 타입여러개 가능
      // 해결책 2 : Union Type
      // 해결책 3 : Dynamic Type
      // 해결책 4 : 변수 만들때 미리 타입을 강제 지정할 수도 있음
      setState(() {
        for (var contact in contacts) {
          var localdata = {};
          localdata['name'] = contact.displayName;
          localdata['tel'] = contact.phones?[0].value;
          data.add(localdata);
        }
        numberAdd();
      });
    } else if (status.isDenied) {
      print("거절됨");

      // 팝업으로 권한을 요청하는 방법
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
      // 주의 : Android 11 이상 ios 환경에서는 거절 2번이상하면 다시는 팝업안뜸

      // 유저가 직접 설정화면에서 권한을 키게 하는 방법 (유저가 어려움을 느끼니 지양)
      // openAppSettings(); // 앱 설정화면 켜줌
    }
  }

  var title = "Contract";
  var numb;
  // 리스트 안에 map 이 있는 구조
  var data = [];

  // initState 안에 적은 코드는 위젯 로드될때 한번 실행됨
  @override
  void initState() {
    super.initState();

    // 되도록 앱시작할때 권한요청 팝업을 띄우는 방법은 지양하자
    // getPermission();
    numb = data.length;
  }

  dataListAdd(nameText, phoneText) {
    print("nameText : $nameText");
    print("phoneText : $phoneText");
    if (nameText == "" || phoneText == "") {
      return false;
    }
    setState(() {
      data.add({"name": nameText.toString(), "tel": phoneText.toString()});
    });
  }

  numberAdd() {
    setState(() {
      numb = data.length;
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
                  dataListAdd: dataListAdd,
                );
              },
            );
          },
        );
      }),
      appBar: AppBar(
        title: Text(numb.toString()),
        actions: [
          IconButton(
            onPressed: () {
              getPermission();
            },
            icon: Icon(Icons.contacts),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Nullable 처리를 해줘야함
                data.sort(
                    (a, b) => a["name"]?.compareTo(b["name"].toString()) ?? 0);
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
        itemCount: data.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (build) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "전화번호 : ${data[i]["tel"]}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.account_circle,
                size: 35,
              ),
              color: Colors.black,
            ),
            title: Text(data[i]["name"].toString()),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  // 리스트에서 특정인덱스 제거
                  data.removeAt(i);
                  numb = data.length;
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
    this.dataListAdd,
  });
  final title;
  final numberAdd;
  final dataListAdd;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  // var inputData = TextEditingController();
  var localInputNameText = "";
  var localInputPhoneText = "";

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
                localInputNameText = text;
              },
              decoration: InputDecoration(hintText: "이름을 입력하세요"),
            ),
            TextField(
              // 웹개발 처럼 onChanged 사용가능 사용자가 입력한 값 : text, 값이 바뀔때 마다 실행이됨
              // onChanged: (text) {},
              onChanged: (text) {
                localInputPhoneText = text;
              },
              decoration: InputDecoration(hintText: "전화 번호를 입력하세요"),
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
                      widget.dataListAdd(
                          localInputNameText, localInputPhoneText);
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
