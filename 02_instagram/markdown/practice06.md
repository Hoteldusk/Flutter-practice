# practice 06

## FireBase
- 일반적으로 DB 저장 방식은 App => Server(데이터검증) => DB
- Server를 직접구축안하고 saas 사용가능

- dependencies 추가
```yaml
firebase_core: ^1.10.6
firebase_auth: ^3.3.4
cloud_firestore: ^3.1.5
```

- 환경변수 등록확인 (C:\Users\heogw\AppData\Local\Pub\Cache\bin)

```bash
dart pub global activate flutterfire_cli
firebase login

# flutterfire 는 bash가 아닌 터미널에서 실행
flutterfire configure --project=flutter-gwangsta

# 이미 추가했으면 skip
flutter pub add firebase_core
flutter pub add firebase_auth
```

- main.dart 에 코드 추가
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(어쩌구~~);

} 
```
- 버전 오류 :  `flutter pub upgrade --major-versions`

- 메모리 오류 : (android > app > build.gradle) defaultConfig => `multiDexEnabled true`

- App ID 가 마음에 안들시 바꾸는 법
```bash
dart pub global run rename --bundleId com.blahblah.blahblah
```

- firebase 데이터 규칙 모두 접근 허용하고싶으면 `allow read, write: if true;` 로 바꿔준다

