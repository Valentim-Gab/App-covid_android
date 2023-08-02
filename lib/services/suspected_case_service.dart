import 'package:app_covid/models/check_symptom.dart';

class SuspectedCaseService {
  String suspectedCaseOrientation(CheckSymptom checkSymptom) {
    if (!isSuspectedCase(checkSymptom)) {
      return 'ESTÁ TUDO BEM';
    }

    if (checkSymptom.qtdDaysSymptoms >= 10) {
      return 'URGENTE: PACIENTE DEVE SER INTERNADO';
    } else if (checkSymptom.qtdDaysSymptoms >= 8) {
      return 'ATENÇÃO: ENCAMINHAR IMEDIATAMENTE PARA AVALIAÇÃO MÉDICA';
    } else if (checkSymptom.qtdDaysSymptoms >= 6) {
      return 'CASO SUSPEITO: PACIENTE DEVE SER ENCAMINHADO PARA EXAMES';
    }

    return 'ESTÁ TUDO BEM';
  }

  bool isSuspectedCase(CheckSymptom checkSymptom) {
    return _calculatePoints(checkSymptom) >= 4;
  }

  int _calculatePoints(CheckSymptom checkSymptom) {
    int points = 0;

    if (checkSymptom.qtdDaysSymptoms > 6) {
      if (_isSevereAcuteRespiratoryIllness(checkSymptom)) {
        points += 4;
      }

      if (checkSymptom.temp > 37.8) {
        points += 2;
      }

      if (checkSymptom.isCough ||
          checkSymptom.isHoarseness ||
          checkSymptom.isSoreThroat ||
          checkSymptom.isStuffyNose) {
        points += 1;
      }
    }

    return points;
  }

  bool _isSevereAcuteRespiratoryIllness(CheckSymptom checkSymptom) {
    bool hasSevereSymptoms = checkSymptom.qtdDaysSymptoms > 6;
    bool hasHighTemperature = checkSymptom.temp > 37.8;
    bool hasCoughOrPhlegm = checkSymptom.isCough || checkSymptom.isPhlegm;

    return hasSevereSymptoms && hasHighTemperature && hasCoughOrPhlegm;
  }
}
