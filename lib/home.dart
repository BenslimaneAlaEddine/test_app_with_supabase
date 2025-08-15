import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/home_pop_up_menu_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.response});
  final AuthResponse response;

  @override
  Widget build(BuildContext context) {
    print(response.user!.id);
    // getData();
    return Scaffold(
      floatingActionButton: AddData(response: response),
      appBar: AppBar(title: const Text("Welcome"), actions: [
        HomePopupMenuButton(response: response),
      ]),
      body: Center(
        child: Column(
          children: [
            Text(
              "Hi ${response.user?.email}: ",
              overflow: TextOverflow.ellipsis,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.hasError);
                    return Column(
                      children: [
                        Text("FirstName: ${snapshot.error}"),
                        Text("SecondName: ${snapshot.error} "),
                      ],
                    );
                  }
                  final data = snapshot.data;
                  print(data);
                  if (data != null) {
                    print(data);
                    return Column(
                      children: [
                        Text(data.isEmpty
                            ? "FirstName: "
                            : "FirstName: ${data[0]["firstName"]}"),
                        Text(data.isEmpty
                            ? "SecondName: "
                            : "SecondName: ${data[0]["secondName"]}"),
                      ],
                    );
                  } else {
                    return const Column(
                      children: [
                        Text("FirstName: "),
                        Text("SecondName: "),
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final response = await Supabase.instance.client
        .from('Profile')
        .select('firstName,secondName');
    return response;
  }
}
