import 'package:app_covid/screens/android/login_screen.dart';
import 'package:flutter/material.dart';

class AppCovid extends StatelessWidget {
  const AppCovid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen()
    );
  }
}

