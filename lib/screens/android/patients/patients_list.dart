import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/screens/android/loader.dart';
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
          Expanded(child: _futureBuilderPatient())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PatientScreen()))
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

  Widget _futureBuilderPatient() {
    return FutureBuilder<List<Patient>>(
      initialData: const [],
      future: PatientDao().getPatients(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;

          case ConnectionState.waiting:
            return const Loader();

          case ConnectionState.active:
            break;

          case ConnectionState.done:
            final List<Patient>? patientList = snapshot.data;

            if (patientList != null && snapshot.hasData) {
              return ListView.builder(
                itemCount: patientList.length,
                itemBuilder: (context, index) {
                  final patient = patientList[index];

                  return PatientsItem(
                    patient: patient,
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => PatientScreen(
                          patient: patient,
                        ),
                      ))
                          .then((value) {
                        setState(() {});
                      });
                    },
                  );
                },
              );
            }

            return const Text('Não há pacientes cadastrados');
        }

        return const Text('Problemas em gerar a lista');
      },
    );
  }

  // ignore: unused_element
  Widget _oldListPatient() {
    List<Patient> patients = [];

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];

        return PatientsItem(
          patient: patient,
          onClick: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => PatientScreen(
                patient: patient,
              ),
            ))
                .then((value) {
              setState(() {});
            });
          },
        );
      },
    );
  }
}
