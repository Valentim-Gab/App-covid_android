import 'dart:io';

import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/Patient.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PatientsAdd extends StatefulWidget {
  const PatientsAdd({super.key});

  @override
  State<PatientsAdd> createState() => _PatientsAddState();
}

class _PatientsAddState extends State<PatientsAdd> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController cardController = TextEditingController();
    final TextEditingController yearsController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar paciente'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _avatarPhoto(context),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome obrigatório';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email obrigatório';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: cardController,
                  decoration: const InputDecoration(
                    labelText: 'Cartão do SUS',
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cartão obrigatório';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: yearsController,
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                  ),
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Idade obrigatória';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  style: const TextStyle(fontSize: 20),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Senha obrigatória';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        PatientDao.add(
                          Patient(
                              0,
                              nameController.text,
                              emailController.text,
                              cardController.text,
                              int.tryParse(yearsController.text)!,
                              passwordController.text),
                        );

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarPhoto(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(150),
      child: InkWell(
        focusColor: Colors.red,
        onTap: () {
          alertTakePicture(context);
        },
        borderRadius: BorderRadius.circular(150),
        child: CircleAvatar(
          backgroundImage: const AssetImage('assets/images/camera.png'),
          radius: 70,
          child: _profilePicture != ''
              ? Image.file(
                  File(_profilePicture),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }

  alertTakePicture(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text(
        'Escolher foto?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content:
          const Text('Escolha entre câmera ou galeria para uma foto de perfil'),
      elevation: 5,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('GALERIA'),
        ),
        TextButton(
          onPressed: () {
            _getAvatarPicture();
            Navigator.of(context).pop();
          },
          child: const Text('CÂMERA'),
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  String _profilePicture = '';

  _getAvatarPicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _profilePicture = pickedImage.path;
      });
    }
  }
}
