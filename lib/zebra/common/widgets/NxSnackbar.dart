import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxSnackbar {
  static void showSuccess(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Adjusted padding
              decoration: BoxDecoration(
                color: ColorConstants.snackBarSuccessCircleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            //SizedBox(width: 6.0),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        backgroundColor: ColorConstants.snackBarBackgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
        duration: duration,
      ),
    );
  }

  static void showError(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Adjusted padding
              decoration: BoxDecoration(
                color: ColorConstants.snackBarErrorCircleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            //SizedBox(width: 6.0),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        backgroundColor: ColorConstants.snackBarBackgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
        duration: duration,
      ),
    );
  }
  static void showvalidationError(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0), // Adjusted padding
              decoration: BoxDecoration(
                color: ColorConstants.snackBarErrorCircleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            //SizedBox(width: 6.0),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        backgroundColor: ColorConstants.snackBarBackgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
        duration: duration,
      ),
    );
  }
}