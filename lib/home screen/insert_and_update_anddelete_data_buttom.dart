import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InsertAndUpdateAndDeleteDataButtom extends StatelessWidget {
  InsertAndUpdateAndDeleteDataButtom(
      {super.key,
      required this.existingData,
      required this.insertData,
      required this.update,
      required this.firstName,
      required this.secondName,
      required this.updated,
      required this.delete,
      required this.callBackMyFutureFromHome});
  final Function() callBackMyFutureFromHome;
  final List existingData;
  final Future<String> Function() insertData;
  final Future<String> Function() update;
  final firstName;
  final secondName;
  bool updated;
  // bool inserted = false;
  final Future<String> Function() delete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: () async {
                final status;
                if (existingData.isEmpty) {
                  // inserted = true;
                  status = await insertData();
                  if (status == "Your data has been sent") {
                    callBackMyFutureFromHome();
                  }
                } else {
                  if (existingData.isNotEmpty) {
                    if ((existingData[0]["firstName"] != firstName.text ||
                            existingData[0]["secondName"] != secondName.text) &&
                        !updated) {
                      status = await update();
                      if (status == "updated avec succes") {
                        callBackMyFutureFromHome();
                      }
                      updated = true;
                    } else {
                      status = "updated";
                    }
                  } else
                    status = "there is no data to update";
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(status),
                  duration: const Duration(seconds: 3),
                ));
              },
              child: Text(existingData.isEmpty ? "Add Data" : "Update Data")),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: OutlinedButton(
                onPressed: () async {
                  final String status;
                  if (existingData.isNotEmpty) {
                    status = await delete();
                    if (status == "Deleted") {
                      callBackMyFutureFromHome();
                    }
                  } else {
                    status = "no data to delete";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(status),
                    duration: const Duration(seconds: 3),
                  ));
                },
                child: const Text("Delete Data"))),
      ],
    );
  }
}
