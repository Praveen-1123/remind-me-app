import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:lottie/lottie.dart';
import 'package:remind_me/helpers/toast.dart';
import 'package:remind_me/services/auth/auth_services.dart';
import 'package:remind_me/utils/snackbar.dart';
import 'package:remind_me/views/widgets/buttons/flexible_button.dart';
import 'package:remind_me/views/widgets/extras/custom_appbar.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({Key key, @required this.email}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _isResendAgain = false;
  bool isLoading = false;

  String _code = '';

  Timer _timer;

  int _start = 60;
  int resendCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    if (_code.length != 6) {
      GetXSnackBar().errorMessage("Invalid Otp", "Please enter a valid otp");
      setState(() {
        isLoading = false;
      });
    } else {
      await AuthServices()
          .verifyEmail(widget.email, int.tryParse(_code), context);
      setState(() {
        isLoading = false;
      });
    }
  }

  void resend() {
    setState(() {
      _isResendAgain = true;
      resendCount = resendCount + 1;
    });
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60 * resendCount;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Verify Email",
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInLeft(
              delay: Duration(milliseconds: 400),
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Container(
                  height: size.height / 3,
                  width: size.width / 1.4,
                  child: Lottie.asset(
                    'assets/lottie/otp.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                FadeInLeft(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Please enter the 6 digit code sent to \n ${widget.email}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: theme.textTheme.bodyText2.color,
                        height: 1.5),
                  ),
                ),
                FadeInLeft(
                  delay: Duration(milliseconds: 600),
                  duration: Duration(milliseconds: 500),
                  child: VerificationCode(
                    length: 6,
                    textStyle: TextStyle(
                        fontSize: 20, color: theme.textTheme.headline1.color),
                    underlineColor: theme.textTheme.headline1.color,
                    keyboardType: TextInputType.number,
                    underlineUnfocusedColor: theme.textTheme.bodyText1.color,
                    onCompleted: (value) {
                      setState(() {
                        _code = value;
                      });
                    },
                    digitsOnly: true,
                    onEditing: (value) {},
                  ),
                ),
                FadeInLeft(
                  delay: Duration(milliseconds: 700),
                  duration: Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't received the OTP?",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade500),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_isResendAgain) return;
                          ToastMessage.toast("Coming soon...");
                          // resend();
                        },
                        child: Text(
                          _isResendAgain
                              ? "Try again in " + _start.toString()
                              : "Resend",
                          style: TextStyle(color: theme.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            FadeInLeft(
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 500),
              child: FlexibleButton(
                isLoading: isLoading,
                text: isLoading ? "Verifying..." : "Verify",
                onPressed: () {
                  verifyOtp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
