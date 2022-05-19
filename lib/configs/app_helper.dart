import 'dart:io';

import 'package:frontend/configs/app_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void messageDialog(BuildContext context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

class CheckConnectivity {
  static checkConnection() async {
    try {
      final result = await InternetAddress.lookup("http://google.com");

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static responseConnection() async {
    debugPrint('network area checking...');
    bool isConnect = await CheckConnectivity.checkConnection();
    if (!isConnect) {
      throw ({'msg': 'tdak ada internet'});
    }
  }
}

getToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getString(keyPref);
}

catchErr(e) {
  return {'success': false, 'message': e.toString()};
}
