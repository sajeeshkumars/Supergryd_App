import 'package:dynamic_fonts/dynamic_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/font_controller.dart';

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
      this.textStyle,
      this.textOverflow});

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
    final controller = Get.find<FontController>();
    return Obx(() {
      return Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines ?? 3,
        overflow: textOverflow,
        style: textStyle ??
            ((controller.fontText.value != "")
                ? DynamicFonts.getFont(controller.fontText.value,
                    textStyle: TextStyle(
                        fontSize: (fontSize ?? 14) /
                            MediaQuery.textScalerOf(context).scale(1),
                        overflow: TextOverflow.ellipsis,
                        color: textColor,
                        fontWeight: fontWeight,
                        decoration: decoration ?? TextDecoration.none))
                : TextStyle(
                    fontSize: (fontSize ?? 14) /
                        MediaQuery.textScalerOf(context).scale(1),
                    overflow: TextOverflow.ellipsis,
                    color: textColor,
                    fontWeight: fontWeight,
                    decoration: decoration ?? TextDecoration.none)),
      );
    });
  }
}
