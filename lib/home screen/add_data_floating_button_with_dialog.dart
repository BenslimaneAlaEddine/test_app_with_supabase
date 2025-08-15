import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_data_form.dart';

class AddDataFloatingButtonWithDialog extends StatelessWidget {
  const AddDataFloatingButtonWithDialog({super.key,
    required this.response,
    required this.keyForm,
    required this.firstName,
    required this.secondName});

  final AuthResponse response;
  final GlobalKey<FormState> keyForm;
  final TextEditingController firstName;
  final TextEditingController secondName;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            useRootNavigator: true,
            context: context,
            builder: (contextD) {
              return AlertDialog(
                scrollable: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddDataForm(
                    keyForm: keyForm,
                    firstName: firstName,
                    secondName: secondName,
                    response: response,
                  ),
                ),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        firstName.clear();
                        secondName.clear();
                      },
                      child: Text("close")),
                ],
              );
            });
      },
      child: const Text("Add data"),
    );
  }
}