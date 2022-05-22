import 'package:flutter/material.dart';
import 'package:appfood/style.dart';

class CartInfoCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const CartInfoCard(
      {Key? key,
      this.icon = Icons.motorcycle,
      this.text = "15 min",
      this.color = Colors.yellow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          size: 15,
          color: lightGray,
        ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
