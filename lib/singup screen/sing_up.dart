import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn/singup%20screen/signup_email_field.dart';
import 'package:learn/singup%20screen/singup_button.dart';
import 'package:learn/singup%20screen/singup_password_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  DateTime? now;

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

  Future<String> singup(
      {required String email, required String password}) async {
    try {
      final response = await Supabase.instance.client.auth
          .signUp(email: email, password: password);
      if (response.user != null && response.user?.emailConfirmedAt != null) {
        print(response.user!.emailConfirmedAt);
        return "done";
      } else if (response.user != null &&
          response.user?.emailConfirmedAt == null) {
        return "A confirmation email has been sent. Please check your inbox and confirm your email**.";
        // print(response.user?.emailConfirmedAt);
      } else {
        return "error user is null";
      }
    } on AuthException catch (e) {
      return "خطأ مصادقة ${e.message}";
    } catch (e) {
      return "خطأ غير متوقع : $e";
    }
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
