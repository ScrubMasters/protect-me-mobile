import 'package:flutter/material.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/microphone_btn.dart';
import 'package:protect_me_mobile/services/alert_service.dart';
import 'package:protect_me_mobile/services/geolocator_service.dart';

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
      body: Builder(
        builder: (context) {
          return Container(
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
                      onPressed: () => _createAlert("LOW"),
                      child: Text("Low"),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () => _createAlert("MEDIUM"),
                      child: Text("Medium"),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
                    RaisedButton(
                      color: Colors.amberAccent,
                      onPressed: () => _createAlert("HIGH"),
                      child: Text("High"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ) 
      
    );
  }

  void _createAlert(String severity) {
    GeolocatorService().getPosition().then(
      (geolocation) {
        AlertService().create({
          "severiry": severity,
          "createdBy": widget.user.id,
          "latitude": geolocation.latitude,
          "longitude": geolocation.longitude
        }, widget.user.token).then(
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