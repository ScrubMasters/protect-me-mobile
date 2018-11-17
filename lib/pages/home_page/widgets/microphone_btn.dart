import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MicrophoneButton extends StatefulWidget {
  @override
  _MicrophoneButtonState createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton> with SingleTickerProviderStateMixin {
  
  Animation<double> _animation;   //> This will increment from 0 to 1 progressively
  AnimationController _animationController;
  
  bool runningAnim = false;

  @override
  void initState() {
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
        if (!runningAnim) {
          _animationController.repeat();
        } else {
          _animationController.stop();
        }
        runningAnim = !runningAnim;
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
