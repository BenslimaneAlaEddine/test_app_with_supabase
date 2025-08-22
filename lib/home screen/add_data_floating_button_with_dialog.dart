import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_data_form.dart';

class AddDataFloatingButtonWithDialog extends StatefulWidget {
  const AddDataFloatingButtonWithDialog(
      {super.key,
      required this.response,
      required this.existingData,
      required this.callBackMyFutureFromHome});
  final Function() callBackMyFutureFromHome;
  final AuthResponse response;
  final List existingData;

  @override
  State<AddDataFloatingButtonWithDialog> createState() => _AddDataFloatingButtonWithDialogState();
}

class _AddDataFloatingButtonWithDialogState extends State<AddDataFloatingButtonWithDialog> {
  final GlobalKey<FormState> keyForm = GlobalKey();

  final TextEditingController firstName = TextEditingController();

  final TextEditingController secondName = TextEditingController();
  @override
  void dispose() {
    firstName.dispose();
    secondName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            // useRootNavigator: true,
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
                      response: widget.response,
                      existingData: widget.existingData,
                      callBackMyFutureFromHome: widget.callBackMyFutureFromHome,
                  contextD:context),
                ),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        firstName.clear();
                        secondName.clear();
                        Navigator.pop(contextD);
                      },
                      child: const Text("close")),
                ],
              );
            });
      },
      child: const Text("Add data"),
    );
  }
}
