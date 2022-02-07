import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/services/yelp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider extends ChangeNotifier {
  List<Restaurant> favourites = [];

  fetchFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('favourites');

    // Retrieve id's of favourites
    List<String> ids = (prefs.getStringList('favourites') ?? []);

    if (ids.isEmpty) {
      return;
    }

    var requests = <Future>[];

    for (var id in ids) {
      requests.add(Yelp.getRestaurantById(id));
    }

    try {
      var data = await Future.wait(requests);

      List<Restaurant> restaurants =
          data.map((restaurant) => restaurant as Restaurant).toList();

      favourites.addAll(restaurants);
    } catch (error) {
      log(error.toString());
    }
  }

  // Add id of favourite
  add(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();

    favourites.add(restaurant);

    prefs.setStringList('favourites',
        favourites.map((Restaurant restaurant) => restaurant.id).toList());

    // Notify widgets to rebuild
    notifyListeners();
  }

  // Remove favourite by id
  remove(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();

    favourites.removeWhere((r) => r.id == restaurant.id);

    prefs.setStringList('favourites',
        favourites.map((Restaurant restaurant) => restaurant.id).toList());

    // Notify widgets to rebuild
    notifyListeners();
  }
}
