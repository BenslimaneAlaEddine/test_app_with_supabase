import 'package:flutter/material.dart';

class AddDataFirstNameField extends StatelessWidget {
  const AddDataFirstNameField({
    super.key,
    required this.firstName,
  });
  final TextEditingController firstName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstName,
      decoration: const InputDecoration(label: const Text("firstName")),
      validator: (value) {
        final regExpName = RegExp(r"^[A-Za-z][a-z]+$");
        if (firstName.text.isEmpty) {
          return "enter firstName field";
        } else {
          if (!regExpName.hasMatch(firstName.text)) return "enter a valid name";
        }
      },
    );
  }
}
