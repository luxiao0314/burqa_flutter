import 'package:fluttertoast/fluttertoast.dart';

class ToastManager {
  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}