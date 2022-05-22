import 'dart:convert';

import 'package:appfood/style.dart';
import 'package:flutter/material.dart';
import 'package:appfood/Screens/Login/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appfood/components/already_have_an_account.dart';
import 'package:appfood/components/rounded_input_field.dart';
import 'package:appfood/components/rounded_password_field.dart';
import 'package:appfood/components/roundedbutton.dart';
import 'package:appfood/models/user_model.dart';
import 'package:appfood/services/preferences_service.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {

  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _Body createState() => _Body();

}

class _Body extends State<Body> {

  String username = "", password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "LOGIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Your Username",
            onChanged: (value) {
              username = value;
            },
          ),
          RoundedPasswordField(
              onChanged: (value) {
                password = value;
              }),
          RoundedButton(
            text: "LOGIN",
            press: () async {
              UserModel user =
                  UserModel(username: username, password: password);
              final response = await authenticateUser(user);
              handle(response, context);
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.of(context).pushNamed('/signup');
            },
          )
        ],
      ),
    );
  }
}

void handle(data, BuildContext context) {
  final bool success = data['success'];
  final _preferencesService = PreferencesService();
  if (success) {
    _preferencesService.saveCustomer(data['accessToken'], data['push']['_id']);
    Navigator.pushNamedAndRemoveUntil(context,"/",(route) => false);
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(data['message']),
  ));
}

Future<Map> authenticateUser(UserModel user) async {
  final newUser = json.encode(user);
  final Uri apiURL = Uri.http(urlServer, "api/customer/login");
  final response = await http.post(apiURL,
      headers: {"Content-Type": "application/json"}, body: newUser);
  final String responseString = response.body;
  return jsonDecode(responseString);
}
