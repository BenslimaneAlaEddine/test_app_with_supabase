import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn/home.dart';
import 'package:learn/login%20screen/singin_button.dart';
import 'package:learn/singup%20screen/sing_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'go_to_signup_text.dart';
import 'login_email_field.dart';
import 'login_password_field.dart';

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
  void dispose() {
emailController.dispose();
passWordController.dispose();
    super.dispose();
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
                        LoginEmailField(emailController: emailController),
                        LoginPasswordField(
                            passWordController: passWordController),
                        LoginButton(
                          keyForm: keyForm,
                          signIn: signIn,
                          emailController: emailController,
                          passWordController: passWordController,
                        ),
                        const GoToSignupText()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      if (response.session != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Home(
                      response: response,
                    )),
            (route) => false);
        return "valid";
      } else {
        print(response.session?.user);
        return "err ${response.session}";
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "خطأ غير متوقع $e";
    }
  }
}
