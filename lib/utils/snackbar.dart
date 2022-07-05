import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXSnackBar {
  void infoMessage(String message, String details) {
    Get.snackbar(
      message,
      details,
      icon: Icon(Icons.info_outline),
      backgroundColor: Colors.lightBlue,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      borderRadius: 10,
      barBlur: 40,
      padding: EdgeInsets.all(8),
    );
  }

  void successMessage(String message, String details) {
    Get.snackbar(
      message,
      details,
      icon: Icon(Icons.check_circle),
      backgroundColor: Colors.lightGreen,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      borderRadius: 10,
      barBlur: 40,
      padding: EdgeInsets.all(8),
    );
  }

  void errorMessage(String message, String details) {
    Get.snackbar(
      message,
      details,
      icon: Icon(Icons.error_outline),
      backgroundColor: Colors.red,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      borderRadius: 10,
      barBlur: 40,
      padding: EdgeInsets.all(8),
    );
  }

  void warningMessage(String message, String details) {
    Get.snackbar(
      message,
      details,
      icon: Icon(Icons.warning_amber_rounded),
      backgroundColor: Colors.orange,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      borderRadius: 10,
      barBlur: 40,
      padding: EdgeInsets.all(8),
    );
  }
}
