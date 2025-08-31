import 'package:flutter/material.dart';
import 'package:learn/home%20screen/add_data.dart';
import 'package:learn/home%20screen/home_pop_up_menu_button.dart';
import 'package:learn/home%20screen/upload_image_to_app.dart';
import 'package:learn/home%20screen/user_data_in_the_home.dart';
import 'package:learn/home%20screen/user_photo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.response});

  final AuthResponse response;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? avatar;

  Future<List<Map<String, dynamic>>> getData() async {
    final response = await Supabase.instance.client
        .from('Profile')
        .select('firstName,secondName,avatar');
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& $response");
    if(response.isNotEmpty)
    if (response[0]["avatar"] != null) {
      setState(() {
        avatar = Supabase.instance.client.storage
            .from("test")
            .getPublicUrl(response[0]["avatar"]);
      });
    }
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
      appBar: AppBar(
          centerTitle: true,
          primary: true,
          toolbarHeight: 90,
          leadingWidth: 90,
          backgroundColor: Colors.blueGrey,
          title: const Text("Welcome"),
          leading: UserPhoto(avatar: avatar),
          actions: [
            HomePopupMenuButton(response: widget.response),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Hi ${widget.response.user?.email}: ",
                overflow: TextOverflow.ellipsis,
              ),
              UserDataInTheHome(myFuture: myFuture),
              UploadImageToApp(set: (image) {
                setState(() {
                  avatar = image;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
