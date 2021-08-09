import 'package:flutter/material.dart';
import 'package:nunta_app/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final Icon icon;
  final TextEditingController controllers;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
    this.icon,
    this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controllers,
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
          ),
          suffixIcon: Icon(Icons.visibility_off),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
        ),
      ),
    );
  }
}
