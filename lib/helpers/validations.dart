import 'package:get/get.dart';

class Validator {
  Future<bool> validateEmail(String email) async {
    return GetUtils.isEmail(email);
  }

  Future<bool> validateUsername(String uername) async {
    return GetUtils.isUsername(uername);
  }
}
