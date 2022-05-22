import 'package:flutter/material.dart';
import 'package:appfood/style.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color;
  final Color textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = purple,
    this.textColor = white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Container(
          color: color,
          width: size.width * 0.8,
          child: TextButton(
            onPressed: press,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
