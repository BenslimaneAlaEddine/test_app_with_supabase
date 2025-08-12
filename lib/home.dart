import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.response});
  final AuthResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome"), actions: [
        PopupMenuButton(onSelected: (value) async {
          if (value == 0) {
            final session = await Supabase.instance.client.auth.currentSession;
            print(
                "*****************************************************************************************");
            print(session);
            await Supabase.instance.client.auth.signOut();
            final sessionEnd =
                await Supabase.instance.client.auth.currentSession;
            print(
                "*****************************************************************************************");
            print(sessionEnd);
            print(response.user);
          }
        }, itemBuilder: (context) {
          return [
            const PopupMenuItem(
              child: Text("Logout"),
              value: 0,
            )
          ];
        }),
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
