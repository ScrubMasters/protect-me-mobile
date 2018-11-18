import 'package:protect_me_mobile/models/geolocation.dart';
import 'package:protect_me_mobile/models/user.dart';

class Alert {
  final String severity;
  final String date;
  final User createdBy;
  final GeoLocation location;
  final String audioUrl;

  Alert({this.severity, this.date, this.createdBy, this.location, this.audioUrl});

  static Alert fromJson(dynamic json, User user) {
    print(json);
    return Alert(
      severity: json["severity"],
      date: json["creation_date"],
      createdBy: user,
      location: GeoLocation("", 
                  json["latitude"],
                  json["latitude"]),
      audioUrl: json["audio"]
    );
  }
}