import 'package:flutter/material.dart';
import 'package:sheti_next/zebra/common/widgets/responsive_util.dart';
import 'package:sheti_next/zebra/constant/ColorConstants.dart';

class NxButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;

  NxButton({
    required this.buttonText,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtil.screenWidth(context) * 0.8;
    return Container(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: ColorConstants.textButtonSaveTextColor,
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtil.fontSize(context, 20),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: ColorConstants.textButtonSaveColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
