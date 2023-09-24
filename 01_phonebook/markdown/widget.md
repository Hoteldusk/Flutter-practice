# 많이 쓰는 위젯 정리
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

- ListView : Column 과 사용법 동일 : 스크롤 바 생김, 스크롤 위치 감시 가능, 메모리 절약가능

- ListView.bilder : itemCount 와 itemBuilder(로직) 을 같이 사용하여 반복문으로 사용가능
```dart
ListView.builder(
  itemCount: 정수형,
  itemBuilder: (context, index) {
    return ListTile(
      leading:
      title:
      trailing:
    );
  }
)
```
- floatingActionButton : 하단에 둥근 버튼을 띄움

- TextButton, IconButton, ElevatedButton : 대표적인 버튼 3개

- 화면전환을 하고싶다면?
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Text("위젯"),
  ),
);
```

- GestureDetector : Text 에 onTap 기능을 넣을수있음 (onDoubleTap 두번 클릭), (onHorizontalDragStart  왼쪽으로 swipe했을때 기능), (onLongPress 확대했을때)

