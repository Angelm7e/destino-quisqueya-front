import 'package:destino_quisqueya_front/anonimusFlow/anonimusHome/anonimusHomeScreen.dart';
import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/screens/auth/forGotEmail/forgotEmailScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/forgotPassword/forgotPasswordScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/signUp/signUpScreenScreen.dart';
import 'package:destino_quisqueya_front/screens/home/homeScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/widgets/buttom.widget.dart';
import 'package:destino_quisqueya_front/widgets/texField.widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassWord = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size base = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: base.height * 0.10),
              Image.asset('assets/mainLogo.png', scale: 4),
              DQTextField(
                controller: emailController,
                hintText: S.of(context).emailHint,
                labelText: S.of(context).emailLabel,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 15),
              DQTextField(
                controller: passwordController,
                hintText: S.of(context).passwordHint,
                labelText: S.of(context).passwordLabel,
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: showPassWord,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassWord = !showPassWord;
                    });
                  },
                  icon: showPassWord
                      ? const Icon(Icons.visibility_off, color: Colors.blue)
                      : const Icon(Icons.visibility, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(ForgotEmailScreen.routeName);
                    },
                    child: Text(
                      S.of(context).forgotEmail,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: base.height * 0.05),
              DQButtom(
                labeltext: S.of(context).loginButton,
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              SizedBox(height: base.height * 0.02),
              DQButtom(
                labeltext: S.of(context).noNeedAccount,
                isPrimary: false,
                onTap: () {
                  Navigator.pushNamed(context, AnonimusHomeScreen.routeName);
                },
              ),
              SizedBox(height: base.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dontHaveAccount,
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Text(
                      S.of(context).signUp,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
