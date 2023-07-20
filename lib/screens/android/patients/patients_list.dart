import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/screens/android/patients/patient_screen.dart';
import 'package:app_covid/screens/android/patients/patients_item.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({super.key});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    List<Patient> patients = PatientDao.listPatients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PACIENTES'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          const TextField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                labelText: 'Pesquisar',
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];

                  return PatientsItem(
                    patient: patient,
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => PatientScreen(
                                    index: index,
                                  )))
                          .then(
                        (value) {
                          setState(() {});
                        },
                      );
                    },
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const PatientScreen()))
              .then(
            (value) {
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
