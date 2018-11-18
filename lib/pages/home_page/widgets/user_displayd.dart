import 'package:flutter/material.dart';
import 'package:protect_me_mobile/environment.dart';
import 'package:protect_me_mobile/models/user.dart';

class UserDisplay extends StatefulWidget {
  final User user;

  UserDisplay(this.user);

  @override
  _UserDisplayState createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  widget.user.avatar,
                )
              )
            ),
          ),
          Text("${widget.user.username}", style: TextStyle(fontSize: 50),)
        ],
      )
    );
  }
}