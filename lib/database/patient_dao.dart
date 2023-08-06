import 'package:app_covid/database/open_database.dart';
import 'package:app_covid/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PatientDao {
  //static final List<Patient> _patientes = [];

  static const String _nameTable = 'patient';
  static const String _col_id = 'id';
  static const String _col_nome = 'nome';
  static const String _col_email = 'email';
  static const String _col_card = 'card';
  static const String _col_years = 'years';
  static const String _col_password = 'password';
  static const String _col_photo = 'photo';

  static const String sqlTablePatient = 'CREATE TABLE $_nameTable ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_nome TEXT, '
      '$_col_email TEXT, '
      '$_col_card TEXT, '
      '$_col_years INTEGER, '
      '$_col_password TEXT, '
      '$_col_photo TEXT)';

  Future<void> add(Patient p) async {
    final Database db = await getDatabase();

    await db.insert(_nameTable, p.toMap());
  }

  Future<dynamic> getPatient(int id) async {
    //_patientes.elementAt(id);

    return null;
  }

  Future<void> update(Patient p) async {
    final Database db = await getDatabase();

    db.update(_nameTable, p.toMap(), where: 'id = ?', whereArgs: [p.id]);
  }

  // static get listPatients {
  //   return _patientes;
  // }

  Future<List<Patient>> getPatients() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_nameTable);

    final patientList = List.generate(maps.length, (index) {
      return Patient(
        maps[index][_col_nome],
        maps[index][_col_email],
        maps[index][_col_card],
        maps[index][_col_years],
        maps[index][_col_password],
        maps[index][_col_photo],
        id: maps[index][_col_id],
      );
    });

    return patientList;
  }
}
