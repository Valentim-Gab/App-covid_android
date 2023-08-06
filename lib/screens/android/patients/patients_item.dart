import 'dart:io';

import 'package:app_covid/database/check_symptom_dao.dart';
import 'package:app_covid/models/check_symptom.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/screens/android/checklist/symptom_checklist.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

class PatientsItem extends StatelessWidget {
  final Patient _patient;
  final Function _onClick;

  const PatientsItem(
      {Key? key, required Patient patient, required Function onClick})
      : _patient = patient,
        _onClick = onClick,
        super(key: key);

  Widget _oldAvatar() {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/avatar.jpg'),
    );
  }

  Color getRandomColor() {
    var color = RandomColor.getColor(Options(luminosity: Luminosity.dark));
    var colorString = color.substring(4, color.length - 1);
    var colorValues = colorString.split(',');

    int red = int.parse(colorValues[0]);
    int green = int.parse(colorValues[1]);
    int blue = int.parse(colorValues[2]);

    return Color.fromARGB(255, red, green, blue);
  }

  Widget _profilePicture() {
    String notProfilePhoto =
        _patient.photo != '' ? '' : _patient.nome.substring(0, 1).toUpperCase();

    return CircleAvatar(
      backgroundColor: getRandomColor(),
      backgroundImage:
          _patient.photo != '' ? FileImage(File(_patient.photo)) : null,
      radius: 22,
      child: Text(
        notProfilePhoto,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: () => _onClick(),
            leading: _profilePicture(),
            title: Text(
              _patient.nome,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              _patient.email,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: _menu(context)),
        const Divider(
          color: AppColors.primaryColor,
          indent: 70,
          endIndent: 20,
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }

  Widget _menu(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<MenuItemsPatientList>>[
        const PopupMenuItem(
          value: MenuItemsPatientList.results,
          child: Text('Resultados'),
        ),
        const PopupMenuItem(
          value: MenuItemsPatientList.newChecklist,
          child: Text('Novo Checklist'),
        )
      ],
      onSelected: (MenuItemsPatientList selected) {
        if (selected == MenuItemsPatientList.newChecklist) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SymptomChecklist(patient: _patient),
            ),
          );
        } else if (selected == MenuItemsPatientList.results) {
          List<CheckSymptom> checkSymptomList =
              CheckSymptomDao.getPatientCheckSymptom(_patient);

          if (checkSymptomList.isNotEmpty) {
            for (CheckSymptom checkSymptom in checkSymptomList) {
              debugPrint(checkSymptom.toString());
            }
          } else {
            debugPrint('Nenhum registro encontrado');
          }
        }
      },
    );
  }
}

enum MenuItemsPatientList { edit, results, newChecklist }
