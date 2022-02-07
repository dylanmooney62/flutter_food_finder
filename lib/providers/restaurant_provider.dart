import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/services/yelp.dart';
import 'package:geocoding/geocoding.dart';

class RestaurantProvider with ChangeNotifier {
  late List<Restaurant> _restaurants = [];

  RestaurantProvider(Location? location) {
    if (location == null) {
    } else {
      fetchRestaurants(location);
    }
  }

  List<Restaurant> get restaurants => _restaurants;

  fetchRestaurants(Location location) async {
    List<Restaurant> res =
        await Yelp.searchRestaurants(location.latitude, location.longitude);

    _restaurants = res;

    notifyListeners();
  }
}
