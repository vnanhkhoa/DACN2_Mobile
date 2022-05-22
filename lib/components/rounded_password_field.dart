import 'package:flutter/material.dart';
import 'package:appfood/components/text_field_container.dart';
import 'package:appfood/style.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double horizontal;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.horizontal = 0,
  }) : super(key: key);
  @override
  _RoundedPasswordField createState() => _RoundedPasswordField();
}

class _RoundedPasswordField extends State<RoundedPasswordField> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      horizontal: widget.horizontal,
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: isShow,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: purple,
          ),
          suffixIcon: IconButton(
            icon: isShow
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            color: purple,
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
