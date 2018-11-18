import 'package:protect_me_mobile/models/geolocation.dart';
import 'package:location/location.dart';

class GeolocatorService {
  Future<GeoLocation> getPosition() async {
    var location = new Location();
    var currentLocation;
    currentLocation = await location.getLocation();
    return GeoLocation("", currentLocation["latitude"], currentLocation["longitude"]);
  }
}