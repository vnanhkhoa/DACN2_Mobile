import 'package:flutter/material.dart';
import 'package:appfood/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(child: Body()));
  }
}
