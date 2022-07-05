import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/views/to-do/create_task.dart';
import 'package:remind_me/views/widgets/buttons/icon_button.dart';
import 'package:remind_me/views/widgets/navigation_anim/fade.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ButtonWithIcon(
          isLoading: isLoading,
          text: "New Task",
          onPressed: () {
            Navigator.push(context, FadeRoute(page: CreateTaskScreen()));
          },
          margin: EdgeInsets.only(left: 50, right: 50),
          width: size.width / 2,
          icon: CupertinoIcons.add,
        ),
      ),
    );
  }
}
