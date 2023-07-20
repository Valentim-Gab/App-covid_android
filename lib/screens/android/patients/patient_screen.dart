import 'dart:io';

import 'package:app_covid/database/patient_dao.dart';
import 'package:app_covid/models/patient.dart';
import 'package:app_covid/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PatientScreen extends StatefulWidget {
  final int? idPatient;

  const PatientScreen({Key? key, int? index})
      : idPatient = index,
        super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isUpdate = false;
  Patient? _patient;

  @override
  Widget build(BuildContext context) {
    if (widget.idPatient != null && !isUpdate) {
      _patient = PatientDao.getPatient(widget.idPatient!);

      if (_patient != null) {
        _patient?.id = widget.idPatient!;
        nameController.text = _patient!.nome;
        emailController.text = _patient!.email;
        cardController.text = _patient!.card;
        yearsController.text = _patient!.years.toString();
        passwordController.text = _patient!.password;
        _profilePicture = _patient!.photo;
        isUpdate = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paciente'),
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
                        bool isUpdate = widget.idPatient != null;

                        Patient patient = Patient(
                          isUpdate ? widget.idPatient : null,
                          nameController.text,
                          emailController.text,
                          cardController.text,
                          int.tryParse(yearsController.text)!,
                          passwordController.text,
                          _profilePicture,
                        );

                        if (isUpdate) {
                          PatientDao.update(patient);
                        } else {
                          PatientDao.add(patient);
                        }

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
            _getAvatarPicture(ImageSource.gallery);
            Navigator.of(context).pop();
          },
          child: const Text('GALERIA'),
        ),
        TextButton(
          onPressed: () {
            _getAvatarPicture(ImageSource.camera);
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

  _getAvatarPicture(ImageSource source) async {
    final imagePicker = ImagePicker();
    try {
      final pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
            sourcePath: pickedImage.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            uiSettings: [
              AndroidUiSettings(
                activeControlsWidgetColor: AppColors.primaryColor,
                toolbarWidgetColor: Colors.white,
                toolbarColor: AppColors.primaryColor,
                toolbarTitle: 'Ajustar imagem',
                statusBarColor: AppColors.primaryColor,
                backgroundColor: Colors.black,
              )
            ]);

        if (cropped != null) {
          setState(() {
            _profilePicture = cropped.path;
          });
        }
      }
    } catch (e) {
      return null;
    }
  }
}
