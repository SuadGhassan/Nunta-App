import 'package:flutter/material.dart';
import 'package:nunta_app/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextEditingController controllers;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controllers,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
        ),
      ),
    );
  }
}
