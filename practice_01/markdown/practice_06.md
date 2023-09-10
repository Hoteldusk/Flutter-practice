# practice_06
## 패키지 설치
- `pubspec.yaml` 에서 dependencies에 라이브러리 설치
- `permission_handler: ^10.4.5` : 유저에게 앱 권한 요청하기 위해 필요한 라이브러리

## import
- `import 'package:permission_handler/permission_handler.dart';`

## 안드로이드 기기 세팅
- `android/gradle.properties` 로 이동 다음과 같이 되어있는지 확인
```gradle
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
```
- sdk 버전확인 : 하단에 버전확인 방법 참고

- Android 기기 세팅 : `android/app/main/AndroidManifest.xml` 확인 다음 항목을 `<application>` 위에 추가
```xml
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
```

### sdk버전확인 방법
- 기존의 sdk 버전확인 방법은 `app/src/build.gradle`에서 확인 이었으나 flutter 설치 폴더내의 `packages/flutter_tools/gradle/flutter` 에서 확인으로 바뀌었다
- 그랬으나 다시 최근에는 flutter 설치 폴더 내 `packages/flutter_tools/src/main/groovy/flutter` 로 바뀌었다