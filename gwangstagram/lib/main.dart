// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gwangstagram/main_page.dart';
import 'package:gwangstagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'upload_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => Store1()),
      ChangeNotifierProvider(create: (c) => Store2()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: style.theme,
      // 페이지가 많아지면 routes 를 사용하자
      // initalRoute: '/', //앱로드시 어떤 routes를 보여줄지
      // routes: {
      //   '/': (context) => Text("첫페이지"),
      //   'detail': (context) => Text("둘째페이지")
      // },
    ),
  ));
}

class Store1 extends ChangeNotifier {
  var follower = 0;
  var isfollower = false;
  var profileImage = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }

  addFollower() {
    if (isfollower) {
      isfollower = false;
      follower--;
    } else {
      isfollower = true;
      follower++;
    }
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier {
  var name = 'john kim';

  changeName() {
    name = 'john park';
    // state 수정후 재렌더링
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  // 여러 자료를 한 변수에 저장하고 싶으면 ?
  // Map, List 안엔 아무거나 다 넣을 수 있다
  // var list = [1, 2, 3];
  // var map = {'name': 'john', 'age': 20};
  // 이름 꺼내는 법 : map['name']

  var dataList = [];
  var userImage;
  var userContent;

  addMyData() {
    var myData = {
      "id": dataList.length,
      "image": userImage,
      "likes": 5,
      "date": "July 25",
      "content": userContent,
      "liked": false,
      "user": "John Kim"
    };
    setState(() {
      // 맨앞에 추가하려면?
      dataList.insert(0, myData);
    });
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  getData() async {
    // initState 에다가 sync붙이지 말고 함수하나 만들어서 sync를 붙이자
    var result = await http
        .get(Uri.parse("https://codingapple1.github.io/app/data.json"));
    if (result.statusCode == 200) {
      // 데이터 불러오기 성공
    } else {
      // 데이터 불러오기 실패
    }
    var result2 = jsonDecode(result.body);
    // Dio 패키지 사용하면 GET 요청이 더 짧아진다
    setState(() {
      dataList = result2;
    });
    print(dataList);
  }

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    // 저장
    // storage.setString('name', 'john');
    // storage.setBool('bool', true);
    // storage.setString(key, value)
    // storage.setStringList(key, value)
    // storage.setInt(key, value)
    // storage.setStringList('list', ['value1', 'value2']);

    // map은 저장이 불가 함으로, json 형식으로 바꿔서 문자열로 저장해야함
    var map = {'age': 20};
    storage.setString('map', jsonEncode(map));
    var result = storage.getString('map') ?? 'null';

    print(jsonDecode(result)['age']);

    // 출력
    // var result = storage.getString('name');
    // getString() 쓰면 뽑은 자료를 String 타입으로 만들어줌
    // print("result:$result");

    // 삭제
    // storage.remove('name');

    // 수신완료한 게시물은 shared_preferences에 저장해두면?
    // shared_preference 에는 image는 저장못함 하드에 캐싱해두어야함
    // Cached network image <= 하드에 사진 저장해주는 라이브러리
  }

  @override
  void initState() {
    super.initState();
    // 앱을 처음로딩했을때 get 요청
    // var result =
    //     http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    // print(result.body);
    // http 함수도 오래걸리는 함수임 (Future)
    getData();

    saveData();
  }

  @override
  Widget build(BuildContext context) {
    // BuildContext context 이게 push 메서드 매개변수로 들어감
    return Scaffold(
      appBar: AppBar(
        title: Text("Gwangstagram"),
        actions: [
          IconButton(
              onPressed: () async {
                // 이미지 띄우는 방법
                var picker = ImagePicker();
                // 카메라 띄우고 싶으면
                // var image = await picker.pickImage(source: ImageSource.camera);

                // 비디오 고르고 싶으면
                // var video = await picker.pickVideo(source: ImageSource.gallery);

                // 여러 이미지를 선택하고 싶으면
                // var images = await picker.pickMultiImage();

                // 갤러리에서 고르고 싶으면
                var image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    userImage = File(image.path); //경로를 저장해서 쓰면됨 nullCheck 해줘야함
                  });
                }

                // 고른 이미지 사이즈 조정가능(가로세로 사이즈 축소, 퀄리티 축소)
                // photofilters 패키지 쓰면 됨

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => Upload(
                      userImage: userImage,
                      setUserContent: setUserContent,
                      addMyData: addMyData,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.add_box_outlined,
              ))
        ],
      ),
      // 레이아웃 중간에 ThmemeData() 생성가능
      // body: Theme(
      //   data: ThemeData(
      //     textTheme: TextTheme(),
      //   ),
      //   child: Container(),
      // ),

      // 원하는 ThemeData 안의 내용 불러오기
      // 가까운 Theme을 찾아서 그안의 내용을 가져옴
      // body: Text(
      //   "안녕",
      //   style: Theme.of(context).textTheme.bodyMedium,
      // ),

      // 탭기능 구현
      // 아래 코드를응용하면 된다. [리스트][꺼낼인덱스]
      body: [
        MainList(
          dataList: dataList,
        ),
        Text("샵페이지")
      ][tab],

      bottomNavigationBar: BottomNavigationBar(
        // 라벨 보기싫을때 추가해주면 라벨 안보임
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // ontab 의 파라미터는 현재 누른 버튼의 번호이다 왼쪽부터 0
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Shop",
          ),
        ],
      ),
    );
  }
}
