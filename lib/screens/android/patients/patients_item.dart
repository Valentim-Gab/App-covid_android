import 'package:app_covid/models/Patient.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PatientsItem extends StatelessWidget {
  final Patient _patient;

  const PatientsItem({Key? key, required Patient patient})
      : _patient = patient,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          title: Text(
            _patient.nome,
            style: const TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            _patient.email,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
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
}
