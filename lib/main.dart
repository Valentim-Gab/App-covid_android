import 'dart:io';

import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/Patient.dart';
import 'package:app_covid/screens/android/app_covid.dart';
import 'package:flutter/material.dart';

void main() {
  generatePatients() {
    PatientDao.add(Patient(0, 'Alencar Machado', 'alencar_machado@ufsm.br',
        'tx232', 33, 'asenhanaoe123', ''));
    PatientDao.add(Patient(1, 'Gabriel Valentim', 'valentim@email.vale',
        'xx444', 20, '123eosguri', ''));
    PatientDao.add(Patient(
        2, 'Eduardo Londero', 'daro@email.vale', 'we151', 22, 'bitwarden', ''));
  }

  if (Platform.isAndroid) {
    generatePatients();
    runApp(const AppCovid());
  }
  if (Platform.isIOS) {
    debugPrint('app no IOS');
  }
  //runApp(const MyApp());
}
