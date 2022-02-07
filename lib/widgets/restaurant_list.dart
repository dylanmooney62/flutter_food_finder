import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:flutter_food_finder/widgets/restaurant_card.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key, required this.restaurants}) : super(key: key);

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    Location? location = context.watch<LocationProvider>().location;

    return ListView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          Restaurant restaurant = restaurants[index];
          String distance;

          if (location == null) {
            distance = "0";
          } else {
            distance = restaurant
                .getDistanceFrom(location.latitude, location.longitude)
                .toStringAsFixed(2);
          }

          return RestaurantCard(restaurant: restaurant, distance: distance);
        });
  }
}
