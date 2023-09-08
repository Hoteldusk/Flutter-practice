# 많이 쓰는 위젯 개념 정리
- MateriaApp 쓰면 구글이 제공하는 위젯 사용가능, 기타 설정도 자동으로 설정됨
- 글자   : `Text("")`
- 아이콘 : `Icon(Icons.아이콘이름)`
- 이미지 : `Image.asset("경로")`, `pubspec.yaml`에다가 등록해야됨

- Container : 상하폭을 줄 수 있음 => 상하폭만 잡을려고 Container 쓰면 Lint가 경고함, SizedBox로 대체 가능

- Center : 내자식 위젯의 기준점을 중앙으로 설정
- Align : 중앙으로 정렬안하고 싶을때
- 가로로 꽉채우고 싶을경우? : width : double.infinity 부모 폭을 넘지않게 꽉채워줌
    
- Scaffold : 상중하로 나눠주는 위젯

- MainAxisAlignment : center, start, end, space~ (row일때 가로축기준, colum일때 세로축 기준)

- padding: EdgeInsets.all(60) : 전체 패딩 60 (margin도 가능)

- 나머지 잡 box 스타일들은 decoration : BoxDecoration()속성 안에 집어넣어야함, border 에서 color잡을때 color 중복정의 되면 오류날때 있음 주의





## 공간 안나올때
```dart
home: Container(
    /// 사이즈 는 LP, 50LP 는 1.2cm
    /// 박스가 꽉차는 이유는 어디서부터 50차지할지 몰라서 그럼
    width: 50,
    height: 50
)
```

