import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class MicrophoneButton extends StatefulWidget {
  final dynamic onRecord;

  MicrophoneButton(this.onRecord);
  
  @override
  _MicrophoneButtonState createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton> with SingleTickerProviderStateMixin {
  
  Animation<double> _animation;   //> This will increment from 0 to 1 progressively
  AnimationController _animationController;

  bool _isRecording = false;
  
  StreamSubscription _recorderSubscription;
  FlutterSound flutterSound;

  String _path = "";

  void startRecorder() async{
    try {
      _path = await flutterSound.startRecorder(null);
      print('startRecorder: $_path');
      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        this.setState(() {
        });
      });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async{
    try {
      String result = await flutterSound.stopRecorder();
      print('stopRecorder: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
      widget.onRecord(_path);
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  void initState() {
    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);

     _animationController = new AnimationController(
      duration: new Duration(milliseconds: 900),
      vsync: this
    );

    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn // Animation increments type
    );
    _animation.addListener(() => this.setState((){}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(200)),
      onTap: () {
        if (!this._isRecording) {
          _animationController.repeat();
          return this.startRecorder();
        }
        _animationController.stop();
        this.stopRecorder();
        
      },
      child: Container(
        padding: EdgeInsets.all(50 + (20 * _animation.value)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(100, 255, 130, 130)
        ),
        child: Icon(Icons.mic, size: 150),
      ),
    );
  }
}
