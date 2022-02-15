import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class Yelp {
  static const String _url = 'https://api.yelp.com/v3/businesses';
  static final Map<String, String> _headers = {
    'authorization': 'Bearer ${dotenv.env['YELP_AUTH_TOKEN']}'
  };

  static Future<List<Restaurant>> getRestaurants(Location location) async {
    try {
      final double lat = location.latitude;
      final double lng = location.longitude;

      Uri query = Uri.parse(
          '$_url/search?term=food&latitude=$lat&longitude=$lng&limit=5');

      var response = await http.get(query, headers: _headers);

      List<dynamic> jsonData = jsonDecode(response.body)['businesses'];

      return jsonData.map((json) => Restaurant.fromJson(json)).toList();
    } catch (error) {
      debugPrint(error.toString());
      return Future.error(error);
    }
  }

  static Future<Restaurant> getRestaurantById(String id) async {
    try {
      Uri query = Uri.parse('$_url/$id');

      var response = await http.get(query, headers: _headers);

      return Restaurant.fromJson(jsonDecode(response.body));
    } catch (error) {
      debugPrint(error.toString());
      return Future.error(error);
    }
  }
}
