import 'package:app_covid/database/check_symptom_dao.dart';
import 'package:app_covid/models/check_symptom.dart';
import 'package:app_covid/screens/android/patients/patients_list.dart';
import 'package:app_covid/services/suspected_case_service.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SCResults extends StatelessWidget {
  CheckSymptom checkSymptom;
  late String _msg;

  SCResults(this.checkSymptom, {super.key}) {
    _msg = SuspectedCaseService().suspectedCaseOrientation(checkSymptom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULTADO'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Text(
            _msg,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          _btnRegister(context),
        ],
      ),
    );
  }

  Widget _btnRegister(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              CheckSymptomDao.add(checkSymptom);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PatientsList()));
            },
            child: const Text('REGISTRAR'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Descartar',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
