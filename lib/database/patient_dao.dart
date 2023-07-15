import 'package:app_covid/models/Patient.dart';

class PatientDao {
  static final List<Patient> _patientes = [];

  static get listPatients {
    _patientes.add(Patient(1, 'Alencar Machado', 'alencar_machado@ufsm.br',
        'tx232', 33, 'asenhanaoe123'));
    _patientes.add(Patient(2, 'Gabriel Valentim', 'valentim@email.vale',
        'xx444', 20, '123eosguri'));
    _patientes.add(Patient(
        3, 'Eduardo Londero', 'daro@email.vale', 'we151', 22, 'bitwarden'));

    return _patientes;
  }
}
