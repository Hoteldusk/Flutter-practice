import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    // var result =
    //     await firestore.collection('product').doc('mJD2C6PCkJ2SwlhReoDB').get();
    // print("result : ${result['price']}");

    // var result = await firestore.collection('product').get();
    // if (result.docs.isNotEmpty) {
    //   for (var doc in result.docs) {
    //     print(doc['name']);
    //   }
    // }

    // 혹은 try catch로 예외처리

    // await firestore.collection('product').add({'name': '내복', 'price': 5000});
    // 저장실패 저장하려면 try catch

    // await firestore.collection('product').where().get();

    // await firestore.collection('product').doc().delete();

    // await firestore.collection('product').doc().update({});

    // 파이어 스토어 규칙 : 사용자 데이터 추가할때 영어인가 숫자인가 길이가 얼마인가 설정가능, 로그인 유저에게만 데이터 보내기 가능

    // 유저 회원가입
    // try {
    //   var result = await auth.createUserWithEmailAndPassword(
    //     email: "park@test.com",
    //     password: "123456",
    //   );
    //   print(result.user);
    //   // 이름을 추가하고싶다면? 가입 진행후 이름을 추가해야함
    //   result.user?.updateDisplayName('john');
    // } catch (e) {
    //   print(e);
    //   // password 가 너무 짧거나, 6자 미만이거나, 이메일이 중복이거나
    // }

    // 유저 로그인
    try {
      await auth.signInWithEmailAndPassword(
        email: "park@test.com",
        password: "123456",
      );
    } catch (e) {
      print(e);
    }

    // 로그인 확인
    if (auth.currentUser?.uid == null) {
      print("로그인 안됨");
    } else {
      print("로그인 됨");
      // 페이지 네비게이트
      print("userID : ${auth.currentUser?.displayName}");
    }

    // 로그 아웃
    // await auth.signOut();

    // 이메일인증, 폰번호 인증요구 가능
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Text('샵페이지');
  }
}
