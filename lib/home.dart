import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.response});
  final AuthResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Text("Hi ${response.user?.email}"),
      ),
    );
  }
}
