import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'go_to_signup_text.dart';
import 'login_email_field.dart';
import 'login_password_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  Future<void> singUp() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        LoginEmailField(emailController: emailController),
                        LoginPasswordField(
                            passWordController: passWordController),
                        OutlinedButton(
                          onPressed: () {
                            print(keyForm.currentState!.validate());
                          },
                          child: const Text("Login"),
                        ),
                        const GoToSignupText()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
