import 'package:app_covid/models/patient.dart';

class CheckSymptom {
  int _id;
  Patient _patient;
  int _temp;
  int _qtdDaysSymptoms;
  bool _isCough;
  bool _isPhlegm;
  bool _isHoarseness;
  bool _isSoreThroat;
  bool _isStuffyNose;
  DateTime _evaluationDate;
  bool? _isSuspiciousCase;

  CheckSymptom(
    this._id,
    this._patient,
    this._temp,
    this._qtdDaysSymptoms,
    this._isStuffyNose,
    this._isSoreThroat,
    this._isHoarseness,
    this._isPhlegm,
    this._isCough,
    this._evaluationDate,
  ) {}

  @override
  String toString() {
    return 'CheckSymptom {'
        ' id: $_id,'
        ' patient: $_patient,'
        ' temp: $_temp,'
        ' qtdDaysSymptoms: $_qtdDaysSymptoms,'
        ' isCough: $_isCough,'
        ' isPhlegm: $_isPhlegm,'
        ' isHoarseness: $_isHoarseness,'
        ' isSoreThroat: $_isSoreThroat,'
        ' isStuffyNose: $_isStuffyNose,'
        ' evaluationDate: $_evaluationDate,'
        ' suspiciousCase: $_isSuspiciousCase'
        ' }';
  }

  int get id => _id;
  Patient get patient => _patient;
  int get temp => _temp;
  int get qtdDaysSymptoms => _qtdDaysSymptoms;
  bool get isCough => _isCough;
  bool get isPhlegm => _isPhlegm;
  bool get isHoarseness => _isHoarseness;
  bool get isSoreThroat => _isSoreThroat;
  bool get isStuffyNose => _isStuffyNose;
  DateTime get evaluationDate => _evaluationDate;
  bool? get isSuspiciousCase => _isSuspiciousCase;

  set id(int value) {
    _id = value;
  }

  set patient(Patient value) {
    _patient = value;
  }

  set temp(int value) {
    _temp = value;
  }

  set qtdDaysSymptoms(int value) {
    _qtdDaysSymptoms = value;
  }

  set isCough(bool value) {
    _isCough = value;
  }

  set isPhlegm(bool value) {
    _isPhlegm = value;
  }

  set isHoarseness(bool value) {
    _isHoarseness = value;
  }

  set isSoreThroat(bool value) {
    _isSoreThroat = value;
  }

  set isStuffyNose(bool value) {
    _isStuffyNose = value;
  }

  set evaluationDate(DateTime value) {
    _evaluationDate = value;
  }

  set isSuspiciousCase(bool? value) {
    _isSuspiciousCase = value;
  }
}
