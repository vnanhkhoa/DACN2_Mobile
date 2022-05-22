import 'package:flutter/material.dart';

class WhiteBox extends StatefulWidget {
  final double height;

  // ignore: use_key_in_widget_constructors
  const WhiteBox(this.height);

  @override
  _WhiteBoxState createState() => _WhiteBoxState();
}

class _WhiteBoxState extends State<WhiteBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
    );
  }
}
