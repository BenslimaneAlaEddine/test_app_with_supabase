import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddData extends StatelessWidget {
  AddData({
    super.key,
    required this.response,
  });
  final AuthResponse response;
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
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
                        child: Text("close"))
                  ],
                );
              });
        },
        child: const Text("Add data"),
      ),
    );
  }
}
