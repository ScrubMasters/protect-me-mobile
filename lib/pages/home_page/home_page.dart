import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protect_me_mobile/models/message.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/alert_button.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/microphone_btn.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/user_displayd.dart';
import 'package:protect_me_mobile/routing.dart';
import 'package:protect_me_mobile/services/alert_service.dart';
import 'package:protect_me_mobile/services/geolocator_service.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _notifications;

  @override
  void initState() {
    Firestore.instance.collection('messages').snapshots().listen(
      (QuerySnapshot q) {
        setState(() {
          print(q.documents);
          List<Message> messages = q.documents.map((d) => Message.fromSnapshot(d)).toList();
          _notifications = messages.where((d) => d.to.username.compareTo(widget.user.username) == 0).toList().length;
        });
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    UserDisplay(widget.user),
                    IconButton(
                      icon: Icon(Icons.chat, size: 40,),
                      onPressed: () {
                        Router.params["user"] = widget.user;
                        Navigator.of(context).pushNamed("/chat_page");
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle
                      ),
                      child: Text(_notifications.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
                MicrophoneButton((path) {
                  _createAlert("HIGH", context);
                }),
                Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AlertButton("LOW", () { _createAlert("LOW", context); }),
                    AlertButton("MEDIUM", () { _createAlert("MEDIUM", context); }),
                    AlertButton("HIGH", () { _createAlert("HIGH", context); }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.symmetric(vertical: 30),),
                        Text("Emergency call", style: TextStyle(color: Colors.white, fontSize: 30),),
                        Padding(padding: EdgeInsets.only(right: 10),),
                        Icon(Icons.call, size: 30, color: Colors.white,)
                      ],
                    ),
                  ),
                )
                ,
              ],
            ),
          );
        },
      ) 
    );
  }

  void _createAlert(String severity, BuildContext context) {
    GeolocatorService().getPosition().then(
      (geolocation) {
        AlertService().create({
          "severity": severity,
          "createdBy": widget.user.id,
          "latitude": geolocation.latitude.toString(),
          "longitude": geolocation.longitude.toString()
        }, widget.user).then(
          (alert) {
            if (alert == null) {
              Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Error sending alert')));
            } else {
              Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Alert created')));
            }
          }
        );
      }
    );
  }
}