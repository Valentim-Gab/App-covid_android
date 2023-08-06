import 'dart:io';

import 'package:app_covid/database/check_symptom_dao.dart';
import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/check_symptom.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/screens/android/checklist/sc_results.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SymptomChecklist extends StatefulWidget {
  final Patient patient;

  const SymptomChecklist({Key? key, required this.patient}) : super(key: key);

  @override
  State<SymptomChecklist> createState() => _SymptomChecklistState();
}

class _SymptomChecklistState extends State<SymptomChecklist> {
  Patient? _patient;
  TextEditingController tempController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  final _formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _patient = widget.patient;
    _isCough = false;
    _isPhlegm = false;
    _isHoarseness = false;
    _isSoreThroat = false;
    _isStuffyNose = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sintomas ${_patient?.nome ?? ''}'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeys,
            child: Column(
              children: [
                _patientAvatar(),
                const CheckBoxSymptom(),
                _tempDaysSymptoms(),
                _registerBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_formKeys.currentState!.validate()) {
            if (_patient != null) {
              CheckSymptom checkSymptom = CheckSymptom(
                0,
                _patient!,
                int.tryParse(tempController.text) ?? -1,
                int.tryParse(daysController.text) ?? -1,
                _isStuffyNose,
                _isSoreThroat,
                _isHoarseness,
                _isPhlegm,
                _isCough,
                DateTime.now(),
              );

              // CheckSymptomDao.add(checkSymptom);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SCResults(checkSymptom)));
            }
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16)),
        child: const Text(
          'REGISTRAR',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _tempDaysSymptoms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
            controller: tempController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Temperatura obrigatória';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Temperatura',
              hintText: 'Digite a temperatura',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: daysController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informar os dias com os sintomas';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Dias com sintomas',
              hintText: 'Digite a quantidade de dias',
            ),
          )
        ],
      ),
    );
  }

  Widget _patientAvatar() {
    return Column(children: [
      ListTile(
        leading: _profilePicture(_patient!),
        title: Text(
          _patient?.nome ?? '',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _patient?.email ?? '',
          style: const TextStyle(fontSize: 15),
        ),
      ),
      const Divider(
        color: AppColors.primaryColor,
        endIndent: 20,
        indent: 70,
        thickness: 1,
        height: 0,
      )
    ]);
  }

  Widget _profilePicture(Patient patient) {
    String notProfilePhoto =
        patient.photo != '' ? '' : patient.nome.substring(0, 1).toUpperCase();

    return CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      backgroundImage:
          patient.photo != '' ? FileImage(File(patient.photo)) : null,
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
}

class CheckBoxSymptom extends StatefulWidget {
  const CheckBoxSymptom({super.key});

  @override
  State<CheckBoxSymptom> createState() => _CheckBoxSymptomState();
}

bool _isCough = false;
bool _isPhlegm = false;
bool _isHoarseness = false;
bool _isSoreThroat = false;
bool _isStuffyNose = false;

class _CheckBoxSymptomState extends State<CheckBoxSymptom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _itemCheck(
            label: 'TOSSE',
            value: _isCough,
            onChanged: () {
              setState(() {
                _isCough = !_isCough;
              });
            },
          ),
          _itemCheck(
            label: 'CATARRO',
            value: _isPhlegm,
            onChanged: () {
              setState(() {
                _isPhlegm = !_isPhlegm;
              });
            },
          ),
          _itemCheck(
            label: 'ROUQUIDÃO',
            value: _isHoarseness,
            onChanged: () {
              setState(() {
                _isHoarseness = !_isHoarseness;
              });
            },
          ),
          _itemCheck(
            label: 'DOR DE GARGANTA',
            value: _isSoreThroat,
            onChanged: () {
              setState(() {
                _isSoreThroat = !_isSoreThroat;
              });
            },
          ),
          _itemCheck(
            label: 'NARIZ ENTUPIDO',
            value: _isStuffyNose,
            onChanged: () {
              setState(() {
                _isStuffyNose = !_isStuffyNose;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _itemCheck(
      {required String label,
      required bool value,
      required Function onChanged}) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      child: Row(
        children: [
          Checkbox(
            onChanged: (bool? newValue) {
              onChanged();
            },
            checkColor: Colors.green,
            activeColor: Colors.white,
            value: value,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 26.0),
          )
        ],
      ),
    );
  }
}
