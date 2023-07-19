import 'package:app_covid/screens/android/login_screen.dart';
import 'package:app_covid/screens/android/patients/patients_list.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('DASHBOARD'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _topMessage(),
              _centerImg(),
              SizedBox(
                height: 120,
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _Element(
                        'PACIENTES',
                        Icons.accessibility_new,
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PatientsList()));
                        },
                      ),
                      _Element(
                        'RESULTADOS',
                        Icons.check_circle_outline,
                        onClick: () {
                          debugPrint('Resultados');
                        },
                      ),
                      _Element(
                        'AGENTES DE SAÚDE',
                        Icons.medical_services_sharp,
                        onClick: () {
                          debugPrint('Agentes');
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _topMessage() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topRight,
        child: Text(
          'Checklist para o COVID-19',
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ));
  }

  Widget _centerImg() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset('assets/images/check_image.jpg'),
          ),
        ));
  }
}

class _Element extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onClick;

  const _Element(this.title, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: AppColors.primaryColor,
        elevation: 10,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onClick,
          child: Container(
            width: 150,
            height: 80,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
