import 'package:flutter/material.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
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
          final passwordRegex = RegExp(
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!\w*([\w.])\1{3,})[\w.]{8,30}$");
          if (val!.isEmpty) {
            return "Please enter a value.\nThis field cannot be left empty.";
          } else if (!passwordRegex.hasMatch(val)) {
            return "Password is too weak. Please use at least 8\n characters, including letters and numbers.";
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
