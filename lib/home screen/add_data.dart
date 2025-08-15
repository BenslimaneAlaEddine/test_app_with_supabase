import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_data_floating_button_with_dialog.dart';

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
      child:AddDataFloatingButtonWithDialog(response: response, keyForm: keyForm, firstName: firstName, secondName: secondName),
    );
  }
}

