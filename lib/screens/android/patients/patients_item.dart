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
            trailing: _menu()),
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

  Widget _menu() {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<MenuItemsPatientList>>[
        const PopupMenuItem(
          value: MenuItemsPatientList.edit,
          child: Text('Editar'),
        ),
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
        debugPrint(selected.toString());
      },
    );
  }
}

enum MenuItemsPatientList { edit, results, newChecklist }
