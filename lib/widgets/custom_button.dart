import 'package:flutter/material.dart';
import 'package:mynewpackage/app_colors.dart';


import 'common_text.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isLoading = false,
      this.height,
      this.width,
      this.backgroundColor,
      this.borderColor,
      this.textColor,
      this.textSize});

  final Function() onPressed;
  final String text;
  final bool? isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: IgnorePointer(
        ignoring: isLoading!,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: borderColor ?? AppColors.primaryColor,
                width: 1,
              ), // Set border radius here
            ),
          ),
          child: Container(
            child: isLoading!
                ?  CircularProgressIndicator(color: AppColors.white,)
                : CommonText(
              textColor: textColor ?? AppColors.white ,
                    text: text,
              textStyle:TextStyle(fontSize: 14) ,
                  ),
          ),
        ),
      ),
    );
  }
}
