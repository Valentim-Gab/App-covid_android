import 'package:app_covid/database/open_database.dart';
import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/check_symptom.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/services/suspected_case_service.dart';
import 'package:sqflite/sqflite.dart';

class CheckSymptomDao {
  //static final List<CheckSymptom> _checkSymptomPatient = [];
  static const String _nameTable = 'check_symptom';
  static const String _colId = 'id_cs';
  static const String _colIdPatient = 'id_patient';
  static const String _colTemp = 'temp';
  static const String _colQtdDaysSymptoms = 'qtd_days_symptoms';
  static const String _colIsCough = 'is_cough';
  static const String _colIsPhlegm = 'is_phlegm';
  static const String _colIsHoarseness = 'is_hoarseness';
  static const String _colIsSoreThroat = 'is_sore_throat';
  static const String _colIsStuffyNose = 'is_stuffy_nose';
  static const String _colEvaluationDate = 'evaluation_date';
  static const String _colIsSuspiciousCase = 'is_suspicious_case';

  static const String sqlTable = 'CREATE TABLE $_nameTable ('
      '$_colId INTEGER PRIMARY KEY, '
      '$_colIdPatient INTEGER, '
      '$_colTemp INTEGER, '
      '$_colQtdDaysSymptoms INTEGER, '
      '$_colIsCough INTEGER, '
      '$_colIsPhlegm INTEGER, '
      '$_colIsHoarseness INTEGER, '
      '$_colIsSoreThroat INTEGER, '
      '$_colIsStuffyNose INTEGER, '
      '$_colEvaluationDate TEXT, '
      '$_colIsSuspiciousCase INTEGER, '
      'FOREIGN KEY ($_colIdPatient) REFERENCES patient(id))';

  Future<void> add(CheckSymptom checkSymptom) async {
    final Database db = await getDatabase();
    checkSymptom.isSuspiciousCase =
        SuspectedCaseService().isSuspectedCase(checkSymptom);

    //_checkSymptomPatient.add(checkSymptom);
    db.insert(_nameTable, checkSymptom.toMap());
  }

  Future<List<CheckSymptom>> getPatientCheckSymptom(Patient patient) async {
    final Database db = await getDatabase();
    const nameTablePatient = PatientDao.nameTable;
    const colIdPatient = PatientDao.colId;
    List<CheckSymptom> checkSymptomList = [];

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $_nameTable cs, $nameTablePatient p '
            'WHERE cs.$_colIdPatient = p.$colIdPatient AND '
            'p.$colIdPatient = ${patient.id.toString()}');

    checkSymptomList = List.generate(maps.length, (index) {
      Patient patient = Patient(
        maps[index][PatientDao.colNome],
        maps[index][PatientDao.colEmail],
        maps[index][PatientDao.colCard],
        maps[index][PatientDao.colYears],
        maps[index][PatientDao.colPassword],
        maps[index][PatientDao.colPhoto],
        id: maps[index][PatientDao.colId],
      );

      CheckSymptom checkSymptom = CheckSymptom(
        patient,
        maps[index][_colTemp],
        maps[index][_colQtdDaysSymptoms],
        maps[index][_colIsStuffyNose] == 1,
        maps[index][_colIsSoreThroat] == 1,
        maps[index][_colIsHoarseness] == 1,
        maps[index][_colIsPhlegm] == 1,
        maps[index][_colIsCough] == 1,
        DateTime.parse(
          maps[index][_colEvaluationDate],
        ),
        id: maps[index][_colId],
      );

      checkSymptom.isSuspiciousCase = maps[index][_colIsSuspiciousCase] == 1;

      return checkSymptom;
    });

    // for (CheckSymptom checkSymptom in _checkSymptomPatient) {
    //   if (patient.id == checkSymptom.patient.id) {
    //     list.add(checkSymptom);
    //   }
    // }

    return checkSymptomList;
  }
}
