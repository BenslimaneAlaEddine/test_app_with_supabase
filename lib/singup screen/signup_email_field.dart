import 'package:flutter/material.dart';

class SignupEmailField extends StatelessWidget {
  const SignupEmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        label: Text("email"),
        border: OutlineInputBorder(),
      ),
      validator: (val) {
        final emailRegex = RegExp(
            r"^[a-zA-Z\d]+([._%+-][a-zA-Z\d]+)*@[a-zA-Z\d]+(\.[a-zA-Z\d]+)*\.[a-zA-Z]{2,20}$");
        if (val!.isEmpty) {
          return "Please enter a value.\nThis field cannot be left empty.";
        } else if (!emailRegex.hasMatch(val)) {
          return "Invalid email format.\nPlease enter a valid email address.";
        }
        return null;
      },
    );
  }
}
