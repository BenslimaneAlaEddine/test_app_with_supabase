import 'package:flutter/material.dart';

class SignupPasswordField extends StatelessWidget {
  const SignupPasswordField({
    super.key,
    required this.passWordController,
  });

  final TextEditingController passWordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: passWordController,
        validator: (val) {
          if (val!.isEmpty) {
            return "Please enter a value.\nThis field cannot be left empty.";
          } else if (val.length < 6) {
            return "The password must be at least 6 characters long.";
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text("passWord"),
          border: OutlineInputBorder(),
        ),
        obscureText: true,
      ),
    );
  }
}