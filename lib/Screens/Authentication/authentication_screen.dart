import 'package:flutter/material.dart';
import 'package:appfood/Screens/Authentication/components/body.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int index = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(child: SingleChildScrollView(child: Body())));
  }
}
