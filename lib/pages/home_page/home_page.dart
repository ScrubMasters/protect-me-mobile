import 'package:flutter/material.dart';
import 'package:protect_me_mobile/models/user.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/alert_button.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/microphone_btn.dart';
import 'package:protect_me_mobile/pages/home_page/widgets/user_displayd.dart';
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
                UserDisplay(widget.user),
                MicrophoneButton((path) {
                  _createAlertAudio(context, path);
                }),
                Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AlertButton("LOW", () { _createAlert("LOW", context); }),
                    AlertButton("MEDIUM", () { _createAlert("MEDIUM", context); }),
                    AlertButton("HIGH", () { _createAlert("HIGH", context); }),
                  ],
                )
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

  void _createAlertAudio(BuildContext context, String path) {
    GeolocatorService().getPosition().then(
      (geolocation) {
        AlertService().createWithAudio({
          "severity": "HIGH",
          "audioPath": path,
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