# practice 03
## 폰에 저장된 이미지 가져오려면?
- image_picker 설치필요
- 아이폰 환경에서 권한요청 필요
```xml
<key>NSPhotoLibraryUsageDescription</key>
<String>사진첩 권한을 요청합니다</String>
<key>NSCameraUsageDescription</key>
<String>카메라 권한을 요청합니다</String>
<key>NSMicrophoneUsageDescription</key>
<String>마이크 권한을 요청합니다</String>
```
- import 추가
```dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';
```

## 데이터 보존방법
1. 서버로 보내서 DB에 저장
2. 폰 메모리카드에 저장(shared preferences) 이용
- 중요한건 DB, 덜 중요한건 shared preference 보관
```dart
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

}
```

## 페이지 전환 커스텀 애니메이션
1. CupertinoPageRoute 사용 => 오른쪽에서 왼쪽으로 화면슬라이드 되면서 전환됨
2. PageRouteBuilder 사용
```dart
PageRouteBuilder(
    pageBuilder: (context, a1, a2) => Profile(),
)
```
- 커스텀 애니메이션 추가가능
```dart
PageRouteBuilder(
    pageBuilder: (context, a1, a2) => Profile(),
    transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
    // transitionsBuilder 에 애니메이션 위젯을 추가하면된다
    // child : 전환시킬 화면 위젯을 뜻함(Profile())
    // a1 : animation object 페이지 전환 얼마나 되었는지 0~1 로 알려줌
)
```
- 애니메이션 위젯의 종류
- `FadeTransition()` `PositionedTransition()` `ScaleTransition()` `RotationTransition()` `SlideTransition()`

- sildeTransition 예시
```dart
SlideTransition(
      position: Tween(
              begin: Offset(-1.0, 0.0),
              end: Offset(0.0, 0.0))
          .animate(a1),
      child: child,
    )
```
- 페이지 전환시 쓰는 Hero() 위젯도 있으니 참고

- 속도조절을 하고싶으면?
- `transitionDuration: Duration(milliseconds: 밀리초입력)` 추가