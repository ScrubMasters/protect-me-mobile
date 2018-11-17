import 'package:protect_me_mobile/models/location.dart';
import 'package:protect_me_mobile/models/user.dart';

class Alert {
  final String severity;
  final String date;
  final User createdBy;
  final Location location;

  Alert({this.severity, this.date, this.createdBy, this.location});

  static Alert fromJson(dynamic json) {
    return Alert(
      severity: json["severity"],
      date: json["date"],
      createdBy: User.fromJson(json["user"], ""),
      location: Location("", json["latitude"], json["longitude"])
    );
  }
}