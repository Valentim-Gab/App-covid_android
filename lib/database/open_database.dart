import 'package:app_covid/database/check_symptom_dao.dart';
import 'package:app_covid/database/patient_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'db_covid19_5.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(PatientDao.sqlTablePatient);
    db.execute(CheckSymptomDao.sqlTable);
  }, version: 1);
}
