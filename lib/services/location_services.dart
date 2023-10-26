import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position?> initialize() async {
    await initPermission();
    bool service = await Geolocator.isLocationServiceEnabled();
    if (service) {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } else {
      service = await Geolocator.openLocationSettings();
      if (service) {
        Position position = await Geolocator.getCurrentPosition();

        return position;
      } else {
        Position? position = await Geolocator.getLastKnownPosition();
        return position;
      }
    }
  }

  Future<bool> initService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    return serviceEnabled;
  }

  Future<void> initPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
