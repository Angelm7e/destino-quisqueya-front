import 'package:destino_quisqueya_front/utilites/constants.dart';
import 'package:destino_quisqueya_front/widgets/dropDonw.widget.dart';
import 'package:destino_quisqueya_front/widgets/texFiel.widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String selectedIen = "Tipo de Identificación";
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading:
          //     // Row(
          //     //   children: [
          //     // Icon(Icons.arrow_back, color: Colors.black),
          //     Text(
          //   "Regresar",
          //   style: TextStyle(fontSize: 18.0),
          // ),
          //   ],
          // ),
          // title: const Text("Create Account"),
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            DQDropDownWidget(
                items: documentTypes,
                selectedItem: selectedIen,
                onChanged: (value) {
                  setState(() {
                    selectedIen = value!;
                    print(selectedIen);
                  });
                }),
            SizedBox(height: 20),
            DQTextField(
              controller: nameController,
              hintText: "hintText",
              labelText: "labelText",
            )
            // Text("Create Account Screen")
          ],
        ),
      ),
    );
  }
}
