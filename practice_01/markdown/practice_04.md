# practice04
```dart
// 버튼에 표시되는 변수가 그대로인이유 : 재렌더링이 되지않았기 때문
// 해결 방법 react 처럼 state를 사용하면 됨
// state 만드는법

// 1. StatefulWidget 만들기 stateful 로 만들던가 혹은 stateless를 stateful로 convert
// state변경 하려면? setState 사용

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // stateful 내부에 변수선언하면 자동으로 state가 됨
  var a = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text("$a"),
          onPressed: () {
            // print(a);
            // a++;
            setState(() {
              a++;
            });
          },
        ),
        appBar: AppBar(
          // 앱 title 같은 경우는 바뀔일이 많이없으니, state로 안만들고 하드코딩해도 무방
          title: Text("연락처앱"),
        ),
        body: ShopItem(),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

/// 위젯 분리방법
/// class 작명 stless
/// return 옆에 축약할 레이아웃 넣기
class ShopItem extends StatefulWidget {
  const ShopItem({super.key});

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  var name = ['가가가', '나나나', '다다다'];
  var like = [0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // child: ListView(
      //   // ListTile 쓰면 더 쉽게 구현 가능
      //   // ListTile 이 100 개 있다면? => 반복문 사용
      //   children: const [
      //     ListTile(
      //       leading: Icon(
      //         Icons.account_circle,
      //         size: 50,
      //         color: Colors.black,
      //       ),
      //       title: Text("홍길동"),
      //     )
      //   ],
      // ),
      child: ListView.builder(
        itemBuilder: (context, index) {
           print("인덱스 : $index"); 
          return ListTile(
            // leading: Icon(
            //   Icons.account_circle,
            //   size: 50,
            //   color: Colors.black,
            // ),
            leading: Text(like[index].toString()),
            title: Text(name[index]),
            trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    like[index]++;
                  });
                },
                child: Text("좋아요")),
          );
        },
        // 배열길이만큼 itemCount 길이 설정
        itemCount: name.length,
      ),
    );
  }
}

// 변수로도 축약가능
// 단 성능 이슈때문에 변하지 않는 UI들 (상단바 등) 만 넣어야함
var a = SizedBox(
  child: Text("안녕"),
);

// 아무거나 다 커스텀 위젯화 하면 안됨
// state 관리가 힘들어짐
// 재사용이 많은 UI들을 커스텀위젯으로 만들어야함

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.account_circle,
          size: 50,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "홍길동",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.phone),
            Icon(Icons.message),
            Icon(Icons.account_box)
          ],
        ),
      ),
    );
  }
}

```