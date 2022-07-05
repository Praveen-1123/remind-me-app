import 'package:flutter/material.dart';
import 'package:remind_me/services/auth/auth_services.dart';
import 'package:remind_me/services/network/connectivity.dart';
import 'package:remind_me/helpers/validations.dart';
import 'package:remind_me/utils/snackbar.dart';
import 'package:remind_me/views/auth/signin_screen.dart';
import 'package:remind_me/views/widgets/buttons/flexible_button.dart';
import 'package:remind_me/views/widgets/navigation_anim/cupertino.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String tokenid = '';
  String buttonText = 'Sign Up';

  bool isLoading = false;

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _cpassword = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signUpValidation() async {
    if (await Connectivity().checkConnection()) {
      if (_email.text == '') {
        GetXSnackBar().errorMessage("Email not found",
            "Please enter your email address to proceed further");
        isLoading = false;
        buttonText = 'Sign Up';
      } else if (await Validator().validateEmail(_email.text) == false) {
        GetXSnackBar().errorMessage(
            "Email not valid", "Please enter a valid email address");
        isLoading = false;
        buttonText = 'Sign Up';
      } else if (_password.text == '') {
        GetXSnackBar().errorMessage("Password not found",
            "Please enter your password to proceed further");
        isLoading = false;
        buttonText = 'Sign Up';
      } else if (_password.text.length < 8) {
        GetXSnackBar().warningMessage(
            "Password is not valid", "Password must be minimum 8 characters");
        isLoading = false;
        buttonText = 'Sign Up';
      } else if (_cpassword.text != _password.text) {
        GetXSnackBar().errorMessage(
            "Password dosen't match", "Password dosen't match. please check");
        isLoading = false;
        buttonText = 'Sign Up';
      } else {
        await AuthServices().signUp(_email.text, _password.text, context);
        isLoading = false;
        buttonText = 'Sign Up';
      }
    } else {
      GetXSnackBar().warningMessage(
          "Failed", "Check your internet connection before continue");
      isLoading = false;
      buttonText = 'Sign Up';
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
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 10),
                    child: RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Sign up',
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
                              'Welcome...\nWe can start something new',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
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
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _cpassword,
                    obscureText: true,
                    cursorColor: theme.textTheme.headline1.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Confirm Password',
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
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      buttonText = 'Signing Up..';
                    });
                    signUpValidation();
                  }),
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
                          'old user?',
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
                                  enterPage: SignInScreen()));
                        },
                        child: Text(
                          'Sign In',
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
