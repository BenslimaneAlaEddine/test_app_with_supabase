import 'package:flutter/material.dart';

class UserDataInTheHome extends StatelessWidget {
  const UserDataInTheHome({super.key, required this.myFuture});

  final Future myFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                Text(data.isEmpty
                    ? "FirstName: "
                    : "FirstName: ${data[0]["firstName"] ?? ''}"),
                Text(data.isEmpty
                    ? "SecondName: "
                    : "SecondName: ${data[0]["secondName"] ?? ''}"),
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
        });
  }
}
