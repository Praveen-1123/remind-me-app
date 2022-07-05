import 'package:flutter/material.dart';
import 'package:remind_me/constants/strings.dart';
import 'package:remind_me/helpers/toast.dart';
import 'package:remind_me/utils/loading_screen.dart';
import 'package:remind_me/views/to-do/main_page.dart';
import 'package:remind_me/views/welcome/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SharedPreferences prefs = snapshot.data;
            bool firstTime = prefs.getBool('first_time');
            bool isLoggedIn = prefs.getBool(login_key);
            if (firstTime != null &&
                !firstTime &&
                isLoggedIn != null &&
                !isLoggedIn) {
              ToastMessage.toast("Welcome to $app_name");
              return IntroScreen();
            } else if (isLoggedIn != null && isLoggedIn) {
              return HomeScreen();
            } else {
              prefs.setBool('first_time', false);
              return IntroScreen();
            }
          }
          return LoadingScreen();
        });
  }
}
