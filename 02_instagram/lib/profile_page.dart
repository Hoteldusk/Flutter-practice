import 'package:flutter/material.dart';
import 'package:gwangstagram/main.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<Store1>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(context.watch<Store2>().name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          SliverGrid.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: context.watch<Store1>().profileImage.length,
            itemBuilder: (c, i) {
              return Image.network(
                context.watch<Store1>().profileImage[i],
                fit: BoxFit.cover,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          // backgroundImage:
          //     NetworkImage(context.watch<Store1>().profileImage[0]),
        ),
        Text("팔로워 ${context.watch<Store1>().follower} 명"),
        ElevatedButton(
          onPressed: () {
            context.read<Store1>().addFollower();
          },
          child: Text("팔로우"),
        ),
      ],
    );
  }
}
