import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final Function snackBar;
  final GlobalKey<FormState> keyForm;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  final Future<void> Function({required String email, required String password})
      singup;
  bool isNotTap;
  DateTime? now;

  SignupButton(
      {super.key,
      required this.keyForm,
      required this.emailController,
      required this.passWordController,
      required this.singup,
      required this.now,
      required this.isNotTap,
      required this.snackBar});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (isNotTap) {
          now = DateTime.now();
        }
        if (keyForm.currentState!.validate()) {
          int timeDifference = DateTime.now().difference(now!).inSeconds;
          if (timeDifference >= 59 || isNotTap) {
            now = DateTime.now();
            singup(
                email: emailController.text, password: passWordController.text);
            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                content: const Text(
                    "A confirmation email has been sent. Please check your inbox and confirm your email"),
                duration: 8));
            isNotTap = false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar(
              content: Text(
                  "you can only request this after ${59 - timeDifference} seconds."),
              duration: 2,
            ));
          }
        }
      },
      child: const Text("Sign up"),
    );
  }
}
