import 'package:flutter/material.dart';
import 'package:remind_me/constants/strings.dart';
import 'package:remind_me/utils/snackbar.dart';
import 'package:remind_me/views/auth/verify_email.dart';
import 'package:remind_me/services/localstorage/getx_storage.dart';
import 'package:remind_me/services/localstorage/shared_references.dart';
import 'package:remind_me/services/network/user_repository.dart';
import 'package:remind_me/views/to-do/main_page.dart';
import 'package:remind_me/views/welcome/intro_screen.dart';
import 'package:remind_me/views/widgets/navigation_anim/fade.dart';

class AuthServices {
  Future<bool> checkAuth() async {
    String email = await readData(ls_email_key);
    String id = await readData(ls_id_key);
    String token = await readData(ls_token_key);

    if (email != null && id != null && token != null) {
      await writePrefsBool(login_key, true);
    } else {
      await writePrefsBool(login_key, false);
    }
    return false;
  }

  Future signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      var data = await Api().signIn(email, password);
      if (data['success']) {
        if (data['result']['auth']) {
          Navigator.pushAndRemoveUntil(
              context, FadeRoute(page: HomeScreen()), (route) => false);
          await writeData(ls_email_key, data['result']['email']);
          await writeData(ls_id_key, data['result']['id']);
          await writeData(ls_token_key, data['result']['token']);
          checkAuth();
        } else {
          Navigator.push(
            context,
            FadeRoute(
              page: VerifyEmail(
                email: email,
              ),
            ),
          );
          GetXSnackBar().warningMessage("Verify Email",
              "Email not verified. Please verify your email to continue");
        }
      } else {
        GetXSnackBar().errorMessage("Failed!", data['result']);
      }
    } catch (e) {
      debugPrint("catch::login::user-$e");
    }
  }

  Future signUp(String email, String password, BuildContext context) async {
    try {
      var data = await Api().signUp(email, password);
      if (data['success']) {
        if (data['result']['code'] != null) {
          await verifyEmail(
              data['result']['email'], data['result']['code'], context);
        } else {
          Navigator.push(
            context,
            FadeRoute(
              page: VerifyEmail(
                email: data['result']['email'],
              ),
            ),
          );
          await writeData(ls_email_key, data['result']['email']);
          await writeData(ls_id_key, data['result']['id']);
        }
      } else {
        GetXSnackBar().errorMessage("Failed!", data['result']);
      }
    } catch (e) {
      debugPrint("catch::signup::user-$e");
    }
  }

  Future verifyEmail(String email, int code, BuildContext context) async {
    try {
      var data = await Api().verifyEmail(email, code);
      if (data['success']) {
        Navigator.pushAndRemoveUntil(
            context, FadeRoute(page: HomeScreen()), (route) => false);
        await writeData(ls_email_key, data['result']['email']);
        await writeData(ls_id_key, data['result']['id']);
        await writeData(ls_token_key, data['result']['token']);
        checkAuth();
      } else {
        GetXSnackBar().errorMessage("Failed!", data['result']);
      }
    } catch (e) {
      debugPrint("catch::verify::email-$e");
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await deleteAllData();
      checkAuth();
      Navigator.pushAndRemoveUntil(
          context, FadeRoute(page: IntroScreen()), (route) => false);
    } catch (e) {
      debugPrint("catch::login::user-$e");
    }
  }
}
