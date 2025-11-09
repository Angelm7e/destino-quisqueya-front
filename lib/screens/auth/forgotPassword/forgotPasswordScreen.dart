import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/widgets/buttom.widget.dart';
import 'package:destino_quisqueya_front/widgets/texField.widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(S.of(context).forgotPassword)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DQTextField(
                controller: controller,
                hintText: "hintText",
                labelText: "labelText",
              ),
              SizedBox(height: 100),
              DQButtom(onTap: () {}, labeltext: "Recover pasword"),
            ],
          ),
        ),
      ),
    );
  }
}
