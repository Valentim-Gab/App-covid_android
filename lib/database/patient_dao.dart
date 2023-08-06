import 'package:app_covid/database/open_database.dart';
import 'package:app_covid/models/patient.dart';
import 'package:sqflite/sqflite.dart';

class PatientDao {
  //static final List<Patient> _patientes = [];
  static const String nameTable = 'patient';
  static const String colId = 'id';
  static const String colNome = 'nome';
  static const String colEmail = 'email';
  static const String colCard = 'card';
  static const String colYears = 'years';
  static const String colPassword = 'password';
  static const String colPhoto = 'photo';

  static const String sqlTablePatient = 'CREATE TABLE $nameTable ('
      '$colId INTEGER PRIMARY KEY, '
      '$colNome TEXT, '
      '$colEmail TEXT, '
      '$colCard TEXT, '
      '$colYears INTEGER, '
      '$colPassword TEXT, '
      '$colPhoto TEXT)';

  Future<void> add(Patient p) async {
    final Database db = await getDatabase();

    await db.insert(nameTable, p.toMap());
  }

  Future<dynamic> getPatient(int id) async {
    //_patientes.elementAt(id);

    return null;
  }

  Future<void> update(Patient p) async {
    final Database db = await getDatabase();

    db.update(nameTable, p.toMap(), where: 'id = ?', whereArgs: [p.id]);
  }

  // static get listPatients {
  //   return _patientes;
  // }

  Future<List<Patient>> getPatients() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(nameTable);
    final patientList = List.generate(maps.length, (index) {
      return Patient(
        maps[index][colNome],
        maps[index][colEmail],
        maps[index][colCard],
        maps[index][colYears],
        maps[index][colPassword],
        maps[index][colPhoto],
        id: maps[index][colId],
      );
    });

    return patientList;
  }
}
