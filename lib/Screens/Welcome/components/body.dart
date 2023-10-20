import 'package:flutter/material.dart';
import 'package:appfood/Screens/Welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appfood/components/rounded_button.dart';
import 'package:appfood/style.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "WELCOME TO GO FOOD",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SvgPicture.asset(
            "assets/icons/order.svg",
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.of(context).pushNamed("/login");
              }),
          RoundedButton(
            text: "SIGN UP",
            press: () {
              Navigator.of(context).pushNamed("/signup");
            },
            color: lightColor,
            textColor: black,
          ),
        ],
      ),
    ));
  }
}
