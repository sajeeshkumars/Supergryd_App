import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

import '../../../../model/font_response.dart';

class FontService extends GetConnect {
  Future<Map<String, String>> getFont() async {
    final rand = Random();
    String url =
        "https://raw.githubusercontent.com/AdarshKSeeroo/fonts/master/setter.json";
    final resp = await get(url);
    if (resp.isOk) {
      print("response is ${resp.body}");
      List list = jsonDecode(resp.body);

      int integ = rand.nextInt(list.length);
      Map<String, dynamic> body = list[integ];
      Map<String, String> map2 = {body["name"]: body["fontWeight"]};
      print("item is $map2");
      return map2;
    }
    return {};
  }

  Future<List<FontResponse>> getFontForRegistration() async {
    String url =
        "https://raw.githubusercontent.com/AdarshKSeeroo/fonts/master/config.json";
    List<FontResponse> list = [];
    final resp = await get(url);
    print("resp is $resp");
    print("resp is ${resp.body}");
    if (resp.isOk) {
      List r = jsonDecode(resp.body);
      for (var e in r) {
        list.add(FontResponse.fromJson(e));
      }
      return list;
    } else {
      return list;
    }
  }
}
