import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class ToastService{
   void showWarnig(String message, BuildContext context) {
    CherryToast.info(
      title: const Text("Action required"),
      action: Text(message),
      animationDuration: Duration(milliseconds: 50),
      toastDuration: Duration(milliseconds: 1000),
      autoDismiss: true,
      animationType: AnimationType.fromRight,
      toastPosition: Position.bottom,
    ).show(context);
  }
  void showError(String message, BuildContext context) {
    CherryToast.error(
      title: Text(message),
      
      animationDuration: Duration(milliseconds: 50),
      toastDuration: Duration(milliseconds: 2000),
      autoDismiss: true,
      animationType: AnimationType.fromRight,
      toastPosition: Position.bottom,
    ).show(context);
  }
  void showSuccess(String message, BuildContext context) {
    CherryToast.success(
      title: const Text("Successful"),
      action: Text(message),
      animationDuration: Duration(milliseconds: 50),
      toastDuration: Duration(milliseconds: 1000),
      autoDismiss: true,
      animationType: AnimationType.fromRight,
      toastPosition: Position.bottom,
    ).show(context);
  }
}