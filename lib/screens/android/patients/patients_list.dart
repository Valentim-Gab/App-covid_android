import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/Patient.dart';
import 'package:app_covid/screens/android/patients/patients_item.dart';
import 'package:flutter/material.dart';

class PatientsList extends StatelessWidget {
  const PatientsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Patient> _patients = PatientDao.listPatients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PACIENTES'),
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
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  final patient = _patients[index];

                  return PatientsItem(
                    patient: patient,
                  );
                }

                // children: const [
                //   PatientsItem(),
                //   PatientsItem(),
                //   PatientsItem(),
                // ],
                ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          debugPrint('Adicionando paciente');
        },
      ),
    );
  }
}
