import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/add_data_first_name_field.dart';
import 'package:learn/home%20screen/add_data_second_name_field.dart';
import 'package:learn/home%20screen/insert_and_update_anddelete_data_buttom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class AddDataForm extends StatelessWidget {
  const AddDataForm(
      {super.key,
      required this.keyForm,
      required this.firstName,
      required this.secondName,
      required this.response,
      required this.existingData,
      required this.callBackMyFutureFromHome,
      required this.contextD});

  final Function() callBackMyFutureFromHome;
  final GlobalKey<FormState> keyForm;
  final TextEditingController firstName;
  final TextEditingController secondName;
  final AuthResponse response;
  final List existingData;
  final BuildContext contextD;

  // bool updated = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: keyForm,
        child: Column(
          children: [
            const Text("Add your data to your profile"),
            AddDataFirstNameField(
              firstName: firstName,
            ),
            AddDataSecondNameField(
              secondName: secondName,
            ),
            InsertAndUpdateAndDeleteDataButtom(
                callBackMyFutureFromHome: callBackMyFutureFromHome,
                existingData: existingData,
                insertData: insertData,
                update: update,
                firstName: firstName,
                secondName: secondName,
                delete: delete,
                contextD: context,
                keyForm: keyForm),
          ],
        ));
  }

  Future<String> insertData() async {
    try {
      if (keyForm.currentState?.validate() ?? false) {
        await Supabase.instance.client.from("Profile").insert({
          "firstName": firstName.text.trim(),
          "secondName": secondName.text.trim(),
          "idUser": response.user?.id
        });
        return "Your data has been sent";
      } else {
        return "not valid";
      }
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "$e";
    }
  }

  Future<String> update() async {
    try {
      if (existingData[0]["firstName"] != firstName.text.trim() &&
          existingData[0]["secondName"] != secondName.text.trim()) {
        await Supabase.instance.client.from("Profile").update({
          "firstName": firstName.text.trim(),
          "secondName": secondName.text.trim()
        }).eq('idUser', response.user!.id);
      } else if (existingData[0]["firstName"] != firstName.text.trim()) {
        await Supabase.instance.client.from("Profile").update({
          "firstName": firstName.text.trim(),
        }).eq('idUser', response.user!.id);
      } else if (existingData[0]["secondName"] != secondName.text.trim()) {
        await Supabase.instance.client.from("Profile").update({
          "secondName": secondName.text.trim(),
        }).eq('idUser', response.user!.id);
      } else {
        return "same data !";
      }
      return "updated avec succes";
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "$e";
    }
  }

  Future<String> delete() async {
    try {
      //ndiro update wradohom null pcq lokan ndiro delete troh gae la lign mn BD c-a-d mm l path tae la photo et tt yroh
      await Supabase.instance.client
          .from("Profile")
          .update({"firstName": null, "secondName": null}).eq(
              "idUser", response.user!.id);
      return "Deleted";
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error";
    }
  }
}
