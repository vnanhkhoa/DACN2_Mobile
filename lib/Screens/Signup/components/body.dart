import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appfood/Screens/Login/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appfood/components/already_have_an_account.dart';
import 'package:appfood/components/rounded_input_field.dart';
import 'package:appfood/components/rounded_password_field.dart';
import 'package:appfood/components/roundedbutton.dart';
import 'package:appfood/models/user_model.dart';
import 'package:appfood/style.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  var username = "";
  var password = "";
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "SIGNUP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
              hintText: "Your Username",
              onChanged: (value) {
                username = value;
              }),
          RoundedPasswordField(
            onChanged: (value) {
              password = value;
            },
          ),
          RoundedButton(
            text: "SIGNUP",
            press: () async {
              if (username.isEmpty || password.isEmpty) return;
              final data = await createUser(
                  UserModel(username: username, password: password));
              handle(data, context);
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.of(context).pushNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}

void handle(data, BuildContext context) {
  final bool success = data['success'];

  if (success) {
    Navigator.of(context).pushNamed("/login");
  }
}

Future<Map> createUser(UserModel user) async {
  final newUser = json.encode(user);
  final Uri apiURL = Uri.http(urlServer, "api/customer/register");
  final response = await http.post(apiURL,
      headers: {"Content-Type": "application/json"}, body: newUser);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return jsonDecode(responseString);
  } else {
    final String responseString = response.body;
    return jsonDecode(responseString);
  }
}
