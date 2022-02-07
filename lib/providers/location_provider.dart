import 'package:flutter/material.dart';
import 'package:flutter_food_finder/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  Location? _location;

  LocationProvider() {
    useLocationFromGPS();
  }

  get location => _location;

  useLocationFromGPS() async {
    Position location = await LocationService.getPosition();

    _location = Location(
        latitude: location.latitude,
        longitude: location.longitude,
        timestamp: DateTime.now());

    notifyListeners();
  }

  useLocationFromAddress(String address) async {
    List<Location> locations =
        await locationFromAddress(address, localeIdentifier: 'en_UK');

    _location = locations[0];

    notifyListeners();
  }
}
