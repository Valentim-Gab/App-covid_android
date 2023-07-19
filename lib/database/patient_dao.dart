import 'package:app_covid/models/Patient.dart';

class PatientDao {
  static final List<Patient> _patientes = [];

  static add(Patient p) {
    _patientes.add(p);
  }

  static get listPatients {
    return _patientes;
  }
}
