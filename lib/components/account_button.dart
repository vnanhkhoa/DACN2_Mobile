import 'package:flutter/material.dart';
import 'package:appfood/style.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final IconData icon;
  final Color color;
  final Color textColor;
  const AccountButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = purple,
    this.textColor = white,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Container(
          color: color,
          width: size.width * 0.8,
          child: TextButton(
            onPressed: press,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      icon,
                      size: 20,
                      color: textColor,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
