import 'dart:io';

import 'package:app_covid/screens/android/app_covid.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    runApp(const AppCovid());
  }

  if (Platform.isIOS) {
    debugPrint('app no IOS');
  }
}
