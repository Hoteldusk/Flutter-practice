# practice_ 02
## 동적인 UI 만드는 법
1. state에 현재 UI의 현재상태 저장
2. state에 따라 UI가 어떻게 보일지 작성
3. 유저가 쉽게 state 조작할 수 있게 만들기

## 서버
- 서버에 GET 요청하고 싶으면 pubspec.yaml에 패키지 설치 필요 `http :`
- android/app/src/main/AndroidManifest.xml 파일 확인
- `<mainfest>` 하단에 다음 코드를 추가
```xml
<uses-permissons android:name="android.permisson.INTERNET" />
```
- `main.dart` 에 import 
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```

### http상태 처리가 번거롭다면 FutureBuilder 사용
- 단 데이터가 나중에 추가안되는 경우에 사용하자 자주추가되면 쓰지말자
```dart
FutureBuilder(future: http.get(), builder: (){})
// future: 에 입력한 Future 가 완료되면 builder: 안의 위젯을 보여준다
```


## 페이지 나누는법
1. Tab
2. Navigator => 페이지 위에다가 덮어 씌움(Stack 으로 관리해줌)
- 장점 : 탭과 다르게 뒤로가기 버튼 잘됨
```dart
Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return Text("새페이지");
                }));
// context : MateriaApp 들어있는 context 넣어야함

// Arrow Func 사용
Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => Text("새페이지")),
                );
```
- routes
```dart
// 페이지가 많아지면 routes 를 사용하자 (routes 쓸때 home 쓰면 오류남)
// 장점 : 페이지 많고 복잡한 앱에 좋음
MaterialApp(
initalRoute: '/', //앱로드시 어떤 routes를 보여줄지
routes: {
  '/': (context) => Text("첫페이지"),
  'detail': (context) => Text("둘째페이지")
},
)

```
- routes 에서 선언한 페이지로 이동하고싶다면?
```dart
Navigator.pushNamed(context, '/detail') //(/detail 페이지로 이동함)
```
