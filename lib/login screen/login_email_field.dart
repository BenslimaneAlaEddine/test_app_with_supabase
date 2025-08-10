import 'package:flutter/material.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration:  const InputDecoration(
        label: Text("email"),
        border: OutlineInputBorder(),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "Please enter a value.\nThis field cannot be left empty.";
        } else if (val.contains("@") == false ||
            val.contains(".") == false) {
          return "Invalid email format.\nPlease enter a valid email address.";
        }
        return null;
      },
    );
  }
}
