import 'dart:ui';

class AppColors {
  static Color backgroundColor = fromHex('#ECF7FF');
  static Color textLightColor = fromHex('#6C7B88');
  static Color white = fromHex('#FFFFFF');
  static Color green = fromHex('#86EAAA');
  static Color primaryColor = fromHex('#0B82E6');
  static Color textColor = fromHex('#455461');
  static Color borderColor = fromHex('#D3D3D3');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
