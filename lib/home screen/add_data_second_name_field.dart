import 'package:flutter/material.dart';

class AddDataSecondNameField extends StatelessWidget {
  const AddDataSecondNameField(
      {super.key, required this.secondName,});

  final TextEditingController secondName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        validator: (value) {
          final regExpName = RegExp(r"^[A-Za-z][a-z]+$");
          if (secondName.text.isEmpty) {
            return "enter firstName field";
          } else {
            if (!regExpName.hasMatch(secondName.text))
              return "enter a valid name";
          }
        },
        controller: secondName,
        decoration: const InputDecoration(label: const Text("secondtName")),
      ),
    );
  }
}
