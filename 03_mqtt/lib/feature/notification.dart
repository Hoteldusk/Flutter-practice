// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification(context) async {
  //안드로이드용 아이콘파일 이름
  var androidSetting =
      const AndroidInitializationSettings('mipmap/ic_launcher');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);

  await notifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload) {
      Navigator.push(
        // context 받아와야함, 매개변수로 받으면됨
        context,
        MaterialPageRoute(
          builder: (context) => const Text('알람 페이지'),
          // payload 버그 많으니 웬만하면 쓰지말자
        ),
      );
    },
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}

//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
// showNotification() async {
//   print('test');
//   var androidDetails = const AndroidNotificationDetails(
//     '유니크한 알림 채널 ID',
//     '알림종류 설명',
//     priority: Priority.high,
//     importance: Importance.max,
//     color: Color.fromARGB(255, 255, 0, 0),
//   );

//   var iosDetails = const DarwinNotificationDetails(
//     presentAlert: true,
//     presentBadge: true,
//     presentSound: true,
//   );
//   // 알림 id, 제목, 내용 맘대로 채우기
//   notifications.show(
//     1, '제목1', '내용1',
//     NotificationDetails(android: androidDetails, iOS: iosDetails),
//     payload: '부가정보', // 부가정보 (유저에게 보이지않음)
//   );
// }

showNotification(String content) async {
  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 채널 ID', //중요도에 따라서 소리여부, 팝업여부 결정가능
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(1, '제목1', content,
      NotificationDetails(android: androidDetails, iOS: iosDetails));
}
