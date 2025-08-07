import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn/singup%20screen/signup_email_field.dart';
import 'package:learn/singup%20screen/singup_button.dart';
import 'package:learn/singup%20screen/singup_password_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  DateTime? now;

  Future<void> singup() async {
    try {
      final reponse = await Supabase.instance.client.auth.signUp(
          email: emailController.text, password: passWordController.text);
      if (reponse.error == null) {
        print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      } else {
        print("nooooooooooooooooooooooooooooo");
      }
    } catch (e) {}
  }

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
                        SignupEmailField(emailController: emailController),
                        SignupPasswordField(
                            passWordController: passWordController),
                        SignupButton(
                          emailController: emailController,
                          passWordController: passWordController,
                          keyForm: keyForm,
                          singup: singup,
                          snackBar: snackBar,
                          now: now,
                          isNotTap: true,
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

  SnackBar snackBar({required Widget content, required int duration}) {
    return SnackBar(
      content: content,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    );
  }
}

extension on AuthResponse {
  get error => null;
}
