import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({
    super.key,
    this.userImage,
    this.setUserContent,
    this.addMyData,
  });

  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Gwangstagram"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
            Image.file(userImage),
            TextField(
              onChanged: (text) {
                setUserContent(text);
              },
            ),
            // 발행버튼 누르면 글 발행?
            IconButton(
              onPressed: () {
                addMyData();
                Navigator.pop(context);
              },
              icon: Icon(Icons.add_circle_outline),
            )
          ],
        ),
      ),
    );
  }
}
