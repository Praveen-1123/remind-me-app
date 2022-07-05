import 'package:flutter/material.dart';
import 'package:remind_me/services/auth/auth_services.dart';
import 'package:remind_me/services/network/connectivity.dart';
import 'package:remind_me/helpers/validations.dart';
import 'package:remind_me/utils/snackbar.dart';
import 'package:remind_me/views/auth/signup_screen.dart';
import 'package:remind_me/views/widgets/buttons/flexible_button.dart';
import 'package:remind_me/views/widgets/navigation_anim/cupertino.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String tokenid = '';
  String buttonText = 'Sign In';

  bool isLoading = false;

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signInValidation() async {
    if (await Connectivity().checkConnection()) {
      if (_email.text == '') {
        GetXSnackBar().errorMessage("Email not found",
            "Please enter your email address to proceed further");
        isLoading = false;
        buttonText = 'Sign In';
      } else if (await Validator().validateEmail(_email.text) == false) {
        GetXSnackBar().errorMessage(
            "Email not valid", "Please enter a valid email address");
        isLoading = false;
        buttonText = 'Sign In';
      } else if (_password.text == '') {
        GetXSnackBar().errorMessage("Password not found",
            "Please enter your password to proceed further");
        isLoading = false;
        buttonText = 'Sign In';
      } else if (_password.text.length < 8) {
        GetXSnackBar().warningMessage(
            "Password is not valid", "Password must be minimum 8 characters");
        isLoading = false;
        buttonText = 'Sign In';
      } else {
        await AuthServices().signIn(
          _email.text,
          _password.text,
          context,
        );
        buttonText = 'Sign In';
        isLoading = false;
      }
    } else {
      GetXSnackBar().warningMessage(
          "Failed", "Check your internet connection before continue");
      isLoading = false;
      buttonText = 'Sign In';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 10),
                  child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 10.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Center(
                          child: Text(
                            'Welcome back...\nHappy to see you again',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _email,
                    cursorColor: theme.textTheme.headline1.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: theme.textTheme.headline1.color,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: theme.textTheme.bodyText1.color,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    cursorColor: theme.textTheme.headline1.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: theme.textTheme.bodyText1.color,
                      ),
                    ),
                  ),
                ),
              ),
              FlexibleButton(
                isLoading: isLoading,
                text: buttonText,
                margin: EdgeInsets.only(left: size.width / 2, top: 25),
                onPressed: () async {
                  setState(() {
                    buttonText = 'Signing In..';
                    isLoading = true;
                  });
                  signInValidation();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Your first time? ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoRoute(
                                  exitPage: this.widget,
                                  enterPage: SignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20,
                              color: theme.textTheme.headline1.color),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
