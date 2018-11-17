import 'package:protect_me_mobile/models/geolocation.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<GeoLocation> getPosition() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("${position.longitude} - ${position.latitude}");
    return GeoLocation("", position.latitude, position.longitude);
  }
}