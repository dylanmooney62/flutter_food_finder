import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Yelp {
  static const String _url = 'https://api.yelp.com/v3/businesses';

  static Future<List<Restaurant>> searchRestaurants(
      double lat, double lng) async {
    try {
      Uri query = Uri.parse(
          '$_url/search?term=food&latitude=$lat&longitude=$lng&limit=5');

      var response = await http.get(query, headers: {
        'authorization': 'Bearer ${dotenv.env['YELP_AUTH_TOKEN']}'
      });

      List<dynamic> list = jsonDecode(response.body)['businesses'];

      return list.map((json) => Restaurant.fromJson(json)).toList();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }

      return Future.error(error);
    }
  }

  static Future<Restaurant> getRestaurantById(String id) async {
    try {
      Uri query = Uri.parse('$_url/$id');

      var response = await http.get(query, headers: {
        'authorization': 'Bearer ${dotenv.env['YELP_AUTH_TOKEN']}'
      });

      return Restaurant.fromJson(jsonDecode(response.body));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }

      return Future.error(error);
    }
  }
}
