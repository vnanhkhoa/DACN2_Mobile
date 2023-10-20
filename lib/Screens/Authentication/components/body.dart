import 'package:flutter/material.dart';
import 'package:appfood/Screens/Authentication/components/background.dart';
import 'package:appfood/components/rounded_password_field.dart';
import 'package:appfood/components/rounded_button.dart';
import 'package:appfood/style.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Create New Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: black,
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Your new password must be different from previous used passwords",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: lightGray,
              ),),
              const SizedBox(height: 10,),
            const Text("Password", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: lightGray,
              ),),
            RoundedPasswordField(onChanged: (value){}, horizontal: 0,),
            const Text("Must be at least 8 characters.", style: TextStyle(
                fontSize: 12,
                color: lightGray,
              ),),
            const SizedBox(height: 10,),
            const Text("Confirm Password", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: lightGray,
              ),),
            RoundedPasswordField(onChanged: (value){}, horizontal: 0,),
            const Text("Both passwords must match", style: TextStyle(
                fontSize: 12,
                color: lightGray,
              ),),
            RoundedButton(text: "Reset Password", color: purple, textColor: white, press: () {})
          ],
        ),
      ),
    );
  }
}