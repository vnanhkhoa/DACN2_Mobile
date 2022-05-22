import 'package:flutter/material.dart';
import 'package:appfood/style.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final void Function() press;
  const AlreadyHaveAnAccountCheck({
    Key? key, this.login = true, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(color: lightGray),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}