import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/models/authModels/dominicanPerson.dart';
import 'package:destino_quisqueya_front/providers/authProvider.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/widgets/buttom.widget.dart';
import 'package:destino_quisqueya_front/widgets/dialog/loadingDialog.dart';
import 'package:destino_quisqueya_front/widgets/dropDonw.widget.dart';
import 'package:destino_quisqueya_front/widgets/genderSelector.widget.dart';
import 'package:destino_quisqueya_front/widgets/texField.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String selectedIen = S.current.documentId;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController passPortController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String currentLocale = Intl.getCurrentLocale();
  DocumentID currentDoc = DocumentID(id: 1, name: S.current.documentId);
  late Authprovider? serv;
  late DominicanPerson? persona;
  String? selectedGender;

  getPersonByCedula(String cedula) async {
    serv = Provider.of<Authprovider>(context, listen: false);
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            LoadingDialog(label: "Cargando informacion de la cedula $cedula"),
      );
      persona = await serv!.getPersonByCedula(cedula);
      nameController.text = persona!.nombres!;
      lastNameController.text = "${persona!.apellido1!} ${persona!.apellido2!}";
      dateOfBirthController.text = persona!.fechaNacimiento!.split(' ')[0];
      // Cargar el género si viene en la respuesta
      if (persona!.idSexo != null && persona!.idSexo!.isNotEmpty) {
        setState(() {
          selectedGender = GenderSelectorWidget.normalizeGender(
            persona!.idSexo,
          );
        });
      }
      Navigator.pop(context);

      final snackBar = SnackBar(
        content: Text(
          "Validacion completada exitosamente, se cargo la informacion de ${persona!.nombres}",
        ),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(S.of(context).register)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 10,
          ),
          child: Column(
            spacing: 15,
            children: [
              DQDropDownWidget(
                items: documentTypes.map((e) => e.name).toList(),
                selectedItem: selectedIen,
                onChanged: (value) {
                  setState(() {
                    selectedIen = value!;
                    currentDoc = documentTypes.firstWhere(
                      (e) => e.name == value,
                    );
                    print(currentDoc.name);
                    print(currentDoc.id);
                  });
                },
              ),
              currentDoc.id == 1
                  ? DQTextField(
                      onChanged: (value) {
                        if (value.length >= 11 && currentDoc.id == 1) {
                          getPersonByCedula("40226547350");
                        }
                      },
                      controller: idController,
                      hintText: S.current.documentId,
                      labelText: S.current.documentId,
                    )
                  : DQTextField(
                      controller: passPortController,
                      hintText: S.current.passport,
                      labelText: S.current.passport,
                    ),
              DQTextField(
                controller: nameController,
                hintText: "Nombre",
                labelText: "Nombre",
              ),
              DQTextField(
                controller: lastNameController,
                hintText: "Apellido",
                labelText: "Apellido",
              ),
              DQTextField(
                controller: dateOfBirthController,
                hintText: "fecha de nacimiento",
                labelText: "fecha de nacimiento",
              ),
              // Selector de género
              GenderSelectorWidget(
                selectedGender: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                labelText: "Género",
              ),

              FlagSelector(
                onFlagSelectorCountryChanged: (country) {
                  print('Selected country: ${country.name}');
                },
              ),
              DQTextField(
                controller: phoneController,
                hintText: "numero de telefono",
                labelText: "numero de telefono",
              ),
              DQTextField(
                controller: emailController,
                hintText: "Correo",
                labelText: "Correo",
              ),
              DQTextField(
                controller: passWordController,
                hintText: "Password",
                labelText: "Password",
              ),
              DQTextField(
                controller: confirmPassWordController,
                hintText: "confirm password",
                labelText: "confirm password",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(horizontalPadding),
        child: DQButtom(
          onTap: () {
            getPersonByCedula("40226547350");
          },
          labeltext: "Registrarse",
        ),
      ),
    );
  }
}
