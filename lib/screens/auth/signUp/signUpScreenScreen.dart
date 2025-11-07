import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/widgets/dropDonw.widget.dart';
import 'package:destino_quisqueya_front/widgets/texFiel.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String selectedIen = S.current.identificationType;
  TextEditingController nameController = TextEditingController();
  String currentLocale = Intl.getCurrentLocale();
  DocumentID? currentDoc;

  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setState(() {
  //       selectedIen = S.of(context).identificationType;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).register)),
      body: SingleChildScrollView(
        child: Padding(
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
                    print(currentDoc!.name);
                    print(currentDoc!.id);
                  });
                },
              ),
              DQTextField(
                controller: nameController,
                hintText: "labelText",
                labelText: "labelText",
              ),
              Text(currentLocale),
            ],
          ),
        ),
      ),
    );
  }
}
