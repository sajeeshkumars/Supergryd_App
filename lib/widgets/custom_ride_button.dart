import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'common_text.dart';

class CustomRideButton extends StatelessWidget {
  CustomRideButton({
    super.key,required this.text,required this.onTap, this.isLoading = false
  });

  final String text;
  final Function() onTap;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(100)),
      child: InkWell(
        onTap: onTap,
        child: Center(
            child:isLoading! ? CircularProgressIndicator(): CommonText(
              text: text,
              textColor: AppColors.primaryColor,
            )),
      ),
    );
  }
}
