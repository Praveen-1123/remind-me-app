import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const MyAppBar({Key key, @required this.title, @required this.actions})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: widget.actions,
            ),
          ),
        ],
      ),
    );
  }
}
