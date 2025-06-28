import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUi {
  static void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Color(0xFF4CE93E),
      textColor: Colors.white,
    );
  }

  static void showError({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Color(0xFFFF4040),
      textColor: Colors.white,
    );
  }

  //   // Alternative approach using custom toast
  //   static void showCustomToast(BuildContext context, {required String msg, bool isError = false}) {
  //     final scaffold = ScaffoldMessenger.of(context);

  //     scaffold.showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           msg,
  //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
  //         ),
  //         backgroundColor: isError ? Colours.coralRedFF4242 : Colours.stoplighGoGreen4CE93E,
  //         behavior: SnackBarBehavior.floating,
  //         margin: const EdgeInsets.all(16),
  //         duration: const Duration(seconds: 3),
  //         action: SnackBarAction(label: 'Close', textColor: Colors.white, onPressed: scaffold.hideCurrentSnackBar),
  //       ),
  //     );
  //   }
}
