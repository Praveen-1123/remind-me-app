import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:remind_me/constants/strings.dart';
import 'package:remind_me/views/auth/signin_screen.dart';
import 'package:remind_me/views/widgets/navigation_anim/cupertino.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: theme.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: FadeInDown(
              delay: Duration(milliseconds: 1000),
              duration: Duration(milliseconds: 500),
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 40,
                  color: theme.textTheme.headline1.color,
                ),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(left: 10, top: 30, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spin(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 1000),
                  child: Center(
                    child: Container(
                      height: size.height / 3,
                      width: size.width / 1.4,
                      child: Lottie.asset(
                        'assets/lottie/travel.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "This application helps you to remind the things you always forgot.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: theme.textTheme.headline1.color,
                    ),
                  ),
                ),
                JelloIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 800),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoRoute(
                                exitPage: this.widget,
                                enterPage: SignInScreen()));
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.textTheme.headline1.color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Text(
                          "GO",
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.textTheme.headline2.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: FadeInUp(
            delay: Duration(milliseconds: 1000),
            duration: Duration(milliseconds: 500),
            child: Container(
              width: size.width,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                "All rights reserved @$app_name 2022",
                style: TextStyle(
                  color: theme.textTheme.bodyText1.color,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
