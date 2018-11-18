import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  final String severity;
  final VoidCallback callback;

  AlertButton(this.severity, this.callback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(200.0)),
        onPressed: callback,
        color: _colorFromSeverity(),
        child: Icon(Icons.error_outline, size: 60, color: Colors.white,),
      )
    ); 
  }

  Color _colorFromSeverity() {
    if (severity == "LOW") {
      return Colors.greenAccent;
    } else if (severity == "MEDIUM") {
      return Colors.amberAccent;
    } else {
      return Colors.redAccent;
    }
  }
}