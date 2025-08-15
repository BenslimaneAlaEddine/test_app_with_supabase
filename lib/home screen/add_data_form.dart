import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/add_data_first_name_field.dart';
import 'package:learn/home%20screen/add_data_second_name_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddDataForm extends StatelessWidget {
  const AddDataForm(
      {super.key,
      required this.keyForm,
      required this.firstName,
      required this.secondName,
      required this.response,});

  final GlobalKey<FormState> keyForm;
  final TextEditingController firstName;
  final TextEditingController secondName;
  final AuthResponse response;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: keyForm,
        child: Column(
          children: [
            const Text("Add your data to your profile"),
            AddDataFirstNameField(firstName: firstName),
            AddDataSecondNameField(secondName: secondName),
            OutlinedButton(
                onPressed: () async {
                  final status = await insertData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(status),
                    duration: const Duration(seconds: 3),
                  ));
                },
                child: const Text("Add Data")),
          ],
        ));
  }

  Future<String> insertData() async {
    try {
      if (keyForm.currentState?.validate() ?? false) {
        await Supabase.instance.client.from("Profile").insert({
          "firstName": firstName.text,
          "secondName": secondName.text,
          "idUser": response.user?.id
        });
        return "Your data has been sent";
      } else
        return "not valid";
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "$e";
    }
  }
}
