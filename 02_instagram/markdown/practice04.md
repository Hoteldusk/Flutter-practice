# practice04
## Provider
- pubspec.yaml 에 패키지 설치 `provider: ^6.0.5`
1. state 보관함(store) 만들기
```dart
class Store1 extends ChangeNotifier {
  var name = 'john kim';
}
```
2. store 원하는 위젯에 등록하기
- 전역에서 쓸려면? MaterialApp 부분에 선언
```dart
ChangeNotifierProvider(
    create: (c) => Store1(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: style.theme,
    ),
)
```
3. 인출 (커스텀 위젯 별로 없으면 3-step 으로 하는게 간단하다)
```dart
context.watch<Store1>().name
```
4. 변경 (store에 메서드를 만들고 사용하자)
```dart
// 등록
class Store1 extends ChangeNotifier {
  var name = 'john kim';
  changeName() {
    name = 'john park';
    // state 수정후 재렌더링
    notifyListeners();
  }
}
// 사용
context.read<Store1>().changeName();
```

### Multi Provider
- provider 를 여러개 쓰려면 다음과 같이 선언한다
```dart
MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => Store1()),
      ChangeNotifierProvider(create: (c) => Store2()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: style.theme,
    ),
)
```
- 꺼내 쓰는건 동일하다

### get 요청으로 데이터 가져와서 state에 넣기
1. provider 에 함수 선언
```dart
getData() async {
 var result = await http
     .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
 var result2 = jsonDecode(result.body);
 profileImage = result2;
 notifyListeners();
}
```
2. 해당 데이터가 필요한 위젯에서 initstate 로 함수호출
3. 사용