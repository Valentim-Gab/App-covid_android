import 'dart:io';

import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SymptomChecklist extends StatefulWidget {
  final int? idPatient;

  const SymptomChecklist({Key? key, this.idPatient}) : super(key: key);

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
    if (widget.idPatient != null) {
      _patient = PatientDao.getPatient(widget.idPatient!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sintomas ${_patient?.nome ?? ''}'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Form(
        key: _formKeys,
        child: Column(
          children: [
            _patientAvatar(),
            _tempDaysSymptoms(),
            _registerBtn(),
          ],
        ),
      ),
    );
  }

  Widget _registerBtn() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_formKeys.currentState!.validate()) {
            debugPrint('sasdf');
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 10)),
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
