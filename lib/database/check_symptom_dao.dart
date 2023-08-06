import 'package:app_covid/models/check_symptom.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/services/suspected_case_service.dart';

class CheckSymptomDao {
  //static final List<CheckSymptom> _checkSymptomPatient = [];

  static add(CheckSymptom checkSymptom) {
    checkSymptom.isSuspiciousCase =
        SuspectedCaseService().isSuspectedCase(checkSymptom);

    //_checkSymptomPatient.add(checkSymptom);
  }

  static List<CheckSymptom> getPatientCheckSymptom(Patient patient) {
    List<CheckSymptom> checkSymptomList = [];

    // for (CheckSymptom checkSymptom in _checkSymptomPatient) {
    //   if (patient.id == checkSymptom.patient.id) {
    //     list.add(checkSymptom);
    //   }
    // }

    return checkSymptomList;
  }
}
