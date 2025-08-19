import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/home_pop_up_menu_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.response});
  final AuthResponse response;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>> getData() async {
    final response = await Supabase.instance.client
        .from('Profile')
        .select('firstName,secondName');
    return response;
  }

  late Future myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.response.user!.id);
    return Scaffold(
      floatingActionButton: AddData(response: widget.response),
      appBar: AppBar(title: const Text("Welcome"), actions: [
        HomePopupMenuButton(response: widget.response),
      ]),
      body: Center(
        child: Column(
          children: [
            Text(
              "Hi ${widget.response.user?.email}: ",
              overflow: TextOverflow.ellipsis,
            ),
            FutureBuilder(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.hasError);
                    return Column(
                      children: [
                        Text(
                          "FirstName: ${snapshot.error}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "SecondName: ${snapshot.error} ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
}
