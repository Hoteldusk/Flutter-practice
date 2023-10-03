# practice05

## 플러터 폴더구조
- 플러터는 프론트엔드 프레임워크라서 굳이 복잡한 구조는 필요없다
- 비슷한 용도의 파일끼리 한폴더에 넣어서 관리하자
- 페이지용 파일들은 pages에, 위젯용 파일들은 widgets 폴더에, store용 파일들은 store 폴더에

## 격자만들 땐 GridView.builder
```dart
GridView.builder(
  // 가로 2열 GridView
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  itemCount: 3,
  itemBuilder: (c, i) {
    return Container(
      color: Colors.grey,
    );
  },
),
```
## 페이지 전체에 스크롤을 주고싶다면 CustomScrollView()
- CustomScrollView 위젯은 slivers사용
- slivers: [] 내부에는 `SliverGrid`, `SiverList()`, `SliverToBoxAdapter()`, `SliverAppBar()`를 사용해야함

## 알림 띄우는 법
1. `flutter_local_notifications` 설치
2. notification 으로 파일 생성
3. 파일 내에 코드 작성
```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification() async {
  //안드로이드용 아이콘파일 이름 (아이콘 변경가능)
  var androidSetting = AndroidInitializationSettings('mipmap/ic_launcher');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onDidReceiveNotificationResponse: 함수명추가
  );
}
```
4. initNotification 함수를 main의 initState에서 실행

### 알람아이콘설정

### 안드로이드
- android/app/src/main/res/drawable 폴더에 이미지를 넣으면됨 (흰색아웃라인만 있는 흰색 .png 만 허용)

### ios
- ios/Runner/AppDelegate.swift 파일에서 GeneratedPluginRegistrant.register(with: self) 코드 윗줄에 다음 코드 작성
```swift
if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
} 
```


5. 알림 띄우는 코드
```dart
showNotification() async {
  var androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID', //중요도에 따라서 소리여부, 팝업여부 결정가능
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1, '제목1', '내용1',
      NotificationDetails(android: androidDetails, iOS: iosDetails));
}
```

6. 알림 눌렀을때 화면이동
```dart
await notifications.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
    Navigator.push(
      // context 받아와야함, 매개변수로 받으면됨
      context,
      MaterialPageRoute(
        builder: (context) => Text('알람 페이지'),
        // payload 버그 많으니 웬만하면 쓰지말자
      ),
    );
  }
)
```