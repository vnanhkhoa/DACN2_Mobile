import 'package:flutter/material.dart';
import 'package:appfood/components/text_field_container.dart';
import 'package:appfood/style.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key, 
    required this.hintText, 
    this.icon = Icons.person, 
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      horizontal: 0,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: purple,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}