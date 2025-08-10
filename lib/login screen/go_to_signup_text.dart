import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn/singup%20screen/sing_up.dart';

class GoToSignupText extends StatelessWidget {
  const GoToSignupText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                  text: "Sign up.",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Signup(),
                      ));
                    })
            ]),
      ),
    );
  }
}
