import 'package:flutter/material.dart';
import 'package:appfood/style.dart';

class TextFieldContainer extends StatefulWidget {
  final Widget child;
  final double horizontal;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.horizontal = 30,
  }) : super(key: key);

  @override
  _TextFieldContainer createState() => _TextFieldContainer();
}

class _TextFieldContainer extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: widget.horizontal, vertical: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width * 0.8,
            color: lightColor,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
