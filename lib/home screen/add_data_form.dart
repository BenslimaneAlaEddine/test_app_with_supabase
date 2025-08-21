import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/add_data_first_name_field.dart';
import 'package:learn/home%20screen/add_data_second_name_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddDataForm extends StatelessWidget {
  AddDataForm(
      {super.key,
      required this.keyForm,
      required this.firstName,
      required this.secondName,
      required this.response,
      required this.existingData});

  final GlobalKey<FormState> keyForm;
  final TextEditingController firstName;
  final TextEditingController secondName;
  final AuthResponse response;
  final List existingData;
  bool updated = false;
  @override
  Widget build(BuildContext context) {
    if (existingData.isNotEmpty) {
      firstName.text = existingData[0]["firstName"];
      secondName.text = existingData[0]["secondName"];
    }
    return Form(
        key: keyForm,
        child: Column(
          children: [
            const Text("Add your data to your profile"),
            AddDataFirstNameField(firstName: firstName),
            AddDataSecondNameField(secondName: secondName),
            OutlinedButton(
                onPressed: () async {
                  final status;
                  if (existingData.isEmpty) {
                    status = await insertData();
                  } else {
                    if ((existingData[0]["firstName"] != firstName.text ||
                            existingData[0]["secondName"] != secondName.text) &&
                        !updated) {
                      status = await update();
                      updated = true;
                    } else {
                      status = "updated";
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(status),
                    duration: const Duration(seconds: 3),
                  ));
                },
                child: Text(existingData.isEmpty ? "Add Data" : "Update Data")),
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
      } else {
        return "nots valid";
      }
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "$e";
    }
  }

  Future<String> update() async {
    try {
      if (existingData[0]["firstName"] != firstName.text &&
          existingData[0]["secondName"] != secondName.text) {
        await Supabase.instance.client.from("Profile").update({
          "firstName": firstName.text,
          "secondName": secondName.text
        }).eq('idUser', response.user!.id);
      } else if (existingData[0]["firstName"] != firstName.text) {
        await Supabase.instance.client.from("Profile").update({
          "firstName": firstName.text,
        }).eq('idUser', response.user!.id);
      } else {
        await Supabase.instance.client.from("Profile").update({
          "secondName": secondName.text,
        }).eq('idUser', response.user!.id);
      }
      return "updated avec succes";
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "$e";
    }
  }
}
