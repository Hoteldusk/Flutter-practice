# practice03
- practice1
```dart
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(children: [
            Text(
              "하나빌",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              color: Colors.black,
              onPressed: () {},
            ),
          ]),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: SizedBox(
          height: 150,
          child: Row(
            children: [
              Image.asset(
                "assets/dog.jpeg",
                width: 200,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" "),
                    Text(" "),
                    Text("도지 코인"),
                    Text(
                      "2023-09-08기준",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text("630원"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                        ),
                        Text("4"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
```
- pratice2
```dart
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: 150,
          child: Row(
            children: [
              Image.asset(
                "assets/dog.jpeg",
                width: 150,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("도지코인"),
                      Text("2023-09-08 현재기준"),
                      Text("630원"),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.favorite_border),
                            Text("4"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
```

- Flexible
```dart
Row(
    children: [
    // 박스폭을 50%로 설정하려면? => Flexible() 로 감싸면 됨
    // 3:7로 하려면?
    // Row, Column 둘다 가능
    Flexible(
        flex: 3,
        child: Container(
        color: Colors.blue,
        // width: 100,
        ),
    ),
    Flexible(
        flex: 7,
        child: Container(
        color: Colors.green,
        // width: 100,
        ),
    )
    ],
),
```

- expanded
```dart
Row(
      children: [
        // 박스를 꽉차게 하고싶다면? expanded 사용 => 고정크기로 설정된 위젯을 제외하고 자리최대로 차지
        Expanded(
          child: Container(
            color: Colors.blue,
          ),
        ),
        Container(
          // 크기 100의 컨테이너를 제외하고 expanded가 크기를 최대로 차지한다
          width: 100,
          color: Colors.red,
        )
      ],
    )
```

- 박스 디자인했는데 의도와 다르다면?
- 1. 사이즈가 이상하다
- 2. 박스 위치가 이상하다
- => devtools를 활용해보자