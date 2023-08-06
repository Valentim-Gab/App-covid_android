import 'package:app_covid/database/patient_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'db_covid19_1.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(PatientDao.sqlTablePatient);
  }, version: 1);
}
