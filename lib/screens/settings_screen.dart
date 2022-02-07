import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key, required this.restaurants}) : super(key: key);

  final Map restaurants;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(restaurants.toString()));
  }
}
