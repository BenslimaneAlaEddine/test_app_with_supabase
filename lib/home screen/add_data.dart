import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_data_floating_button_with_dialog.dart';

class AddData extends StatelessWidget {
  AddData(
      {super.key,
      required this.response,
      required this.existingData,
      required this.callBackMyFutureFromHome});
  final Function({required bool isInitState}) callBackMyFutureFromHome;
  final AuthResponse response;
  final List existingData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: AddDataFloatingButtonWithDialog(
        callBackMyFutureFromHome: callBackMyFutureFromHome,
        existingData: existingData,
        response: response,
      ),
    );
  }
}
