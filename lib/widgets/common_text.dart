import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {super.key,
      required this.text,
      this.fontSize,
      this.textColor,
      this.maxLines,
      this.fontWeight,
      this.decoration,
      this.textAlign,
      this.textStyle, this.textOverflow});

  final String text;
  final double? fontSize;
  final int? maxLines;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 3,
      overflow: textOverflow,
      style: textStyle ??
          TextStyle(
              fontSize: fontSize,
              overflow: TextOverflow.ellipsis,
              color: textColor,
              fontWeight: fontWeight,
              decoration: decoration ?? TextDecoration.none),
    );
  }
}
