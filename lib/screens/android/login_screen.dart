import 'package:app_covid/screens/android/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Tela de Login'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => const DashboardScreen()));
            },
            icon: const Icon(Icons.login),
            label: const Text(
              'LOGIN',
              style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 5.0,
                padding: const EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
        ));
  }
}
