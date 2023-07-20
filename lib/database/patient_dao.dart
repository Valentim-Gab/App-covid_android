import 'package:app_covid/models/patient.dart';
import 'package:flutter/material.dart';

class PatientDao {
  static final List<Patient> _patientes = [];

  static add(Patient p) {
    _patientes.add(p);
  }

  static Patient getPatient(int id) {
    return _patientes.elementAt(id);
  }

  static void update(Patient p) {
    debugPrint('\n$_patientes\n');
    debugPrint(p.toString());
    if (p.id != null) {
      _patientes.replaceRange(p.id!, p.id! + 1, [p]);
    }
    debugPrint('\n$_patientes\n');
  }

  static get listPatients {
    return _patientes;
  }
}
