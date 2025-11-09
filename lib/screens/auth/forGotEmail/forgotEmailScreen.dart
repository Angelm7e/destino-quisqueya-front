import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/widgets/buttom.widget.dart';
import 'package:destino_quisqueya_front/widgets/texField.widget.dart';
import 'package:flutter/material.dart';

class ForgotEmailScreen extends StatefulWidget {
  const ForgotEmailScreen({super.key});

  static const String routeName = '/forgotEmailScreen';

  @override
  State<ForgotEmailScreen> createState() => _ForgotEmailScreenState();
}

class _ForgotEmailScreenState extends State<ForgotEmailScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("forgot email")),
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
              DQButtom(onTap: () {}, labeltext: "Send recovery code"),
            ],
          ),
        ),
      ),
    );
  }
}
