import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.keyForm,
      required this.signIn,
      required this.emailController,
      required this.passWordController});

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  final Future<String> Function(
      {required String email, required String password}) signIn;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        if (keyForm.currentState!.validate()) {
          String status = await signIn(
              email: emailController.text, password: passWordController.text);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(status),
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: const Text("Login"),
    );
  }
}
