import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

alertDialog(BuildContext context, String msg) {
  ToastContext().init(context);
  Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.bottom);
}
