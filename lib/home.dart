import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/home_pop_up_menu_button.dart';
import 'package:learn/login%20screen/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.response});
  final AuthResponse response;

  @override
  Widget build(BuildContext context) {
    print(response.user!.id);
    return Scaffold(
      floatingActionButton: AddData(response: response),
      appBar: AppBar(title: const Text("Welcome"), actions: [
        HomePopupMenuButton(response: response),
      ]),
      body: Center(
        child: Text(
          "Hi ${response.user?.email}: ",
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
