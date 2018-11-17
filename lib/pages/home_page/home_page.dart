import 'package:flutter/material.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/microphone_btn.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MicrophoneButton(),
            Padding(padding: EdgeInsets.only(top: 40)),
            Text(widget.user.username, style: TextStyle(fontSize: 50),),
            Padding(padding: EdgeInsets.only(top: 40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {},
                  child: Text("Lleu"),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {},
                  child: Text("Normal"),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
                RaisedButton(
                  color: Colors.amberAccent,
                  onPressed: () {},
                  child: Text("Greu"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}