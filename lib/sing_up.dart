import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            label: Text("email"),
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter a value.\nThis field cannot be left empty.";
                            } else if (val.contains("@") == false ||
                                val.contains(".") == false) {
                              return "Invalid email format.\nPlease enter a valid email address.";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            controller: passWordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter a value.\nThis field cannot be left empty.";
                              } else if (val.length < 6) {
                                return "The password must be at least 6 characters long.";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("passWord"),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            print(keyForm.currentState!.validate());
                          },
                          child: const Text("Sign up"),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
