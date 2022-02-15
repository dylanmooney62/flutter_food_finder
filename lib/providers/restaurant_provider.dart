import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/services/yelp.dart';
import 'package:geocoding/geocoding.dart';

class RestaurantProvider with ChangeNotifier {
  late List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  RestaurantProvider(Location? location) {
    if (location == null) return;

    fetchRestaurants(location);
  }

  fetchRestaurants(Location location) async {
    _restaurants = await Yelp.getRestaurants(location);

    notifyListeners();
  }
}
