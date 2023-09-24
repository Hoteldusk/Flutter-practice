import 'package:flutter/material.dart';

import 'profile_page.dart';

class MainList extends StatelessWidget {
  const MainList({
    super.key,
    this.dataList,
  });

  final dataList;

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      return ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (c, i) {
            return BusanContent(data: dataList[i]);
          });
    } else {
      return Text("로딩중");
    }
  }
}

class BusanContent extends StatelessWidget {
  // stateful 일경우 widget. 으로 접근
  // stateless 일경우 그냥 접근
  const BusanContent({
    super.key,
    this.data,
  });
  final data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          width: double.infinity,
          // height: 400,
          // child: Image(
          //   // image: AssetImage("images/busan.jpeg"),

          //   // image: NetworkImage(data['image']),
          //   // image: NetworkImage(""), 서버에서 이미지 받는것도 가능
          //   fit: BoxFit.cover,
          // ),
          child: data['image'].runtimeType == String
              ? Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                )
              : Image.file(
                  data['image'],
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text에 onPressed 넣고싶으면 GestureDetector 사용
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, a1, a2) => Profile(),
                      transitionsBuilder: (context, a1, a2, child) =>
                          FadeTransition(opacity: a1, child: child),
                      transitionDuration: Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Text(
                  "글쓴이 : ${data['user']}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                "좋아요 : ${data['likes']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("내용 : ${data['content']}"),
              Text("날짜 : ${data['date']}"),
            ],
          ),
        )
      ],
    );
  }
}
