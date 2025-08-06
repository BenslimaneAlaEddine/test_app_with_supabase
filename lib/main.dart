import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://tmbkwagwasmokppzvfku.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRtYmt3YWd3YXNtb2twcHp2Zmt1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MzUyODMsImV4cCI6MjA3MDAxMTI4M30.X-SYAGw73KK58SgSccWXXGk72e-LdANHDMCpSqWFQFg",
  );
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                          child: const Text("Login"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: RichText(
                            text: TextSpan(
                                text: "Don't have an account? ",style: TextStyle(color: Colors.black),
                                children: [TextSpan(text: "Sign up.",style: TextStyle(color: Colors.blue),recognizer: TapGestureRecognizer()..onTap=(){})]),
                          ),
                        )
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
