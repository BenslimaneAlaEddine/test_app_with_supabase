import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/home_pop_up_menu_button.dart';
import 'package:learn/home%20screen/user_data_in_the_home.dart';
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

  //   Future<dynamic> getData() async {
  //     try {
  //       final response = await Supabase.instance.client
  //           .from('Profile')
  //           .select('firstName,secondName');
  //       return response;
  //     }
  //     on PostgrestException catch(e){
  //       return e.message;
  //     }
  //     catch(e){
  //       return "Exception error";
  //     }
  //   }

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
      floatingActionButton: FutureBuilder(
          future: myFuture,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (asyncSnapshot.hasError) return const Text("error");
            // existingData = asyncSnapshot.data ?? [];
            return AddData(
              callBackMyFutureFromHome: () {
                setState(() {
                  myFuture = getData();
                });
              },
              response: widget.response,
              existingData: asyncSnapshot.data ?? [],
            );
          }),
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
            UserDataInTheHome(myFuture: myFuture)
          ],
        ),
      ),
    );
  }
}

