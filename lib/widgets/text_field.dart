import 'package:flutter/material.dart';

class ProtectMeTextField extends StatelessWidget {
  final String name;
  final dynamic onValid;
  final double padding;

  const ProtectMeTextField({Key key, this.name, this.onValid, this.padding = 10 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: this.padding),
      child: TextFormField(
        obscureText: name == "Password",
        decoration: InputDecoration(
          hintText: name
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the $name';
          } else {
            onValid(value);
          }
        },
      ),
    );
  }
}