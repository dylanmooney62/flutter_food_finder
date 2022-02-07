import 'package:flutter/material.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  _onSearch(String address) {
    if (address.isEmpty) {
      context.read<LocationProvider>().useLocationFromGPS();
    } else {
      context.read<LocationProvider>().useLocationFromAddress(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onFieldSubmitted: (String address) => _onSearch(address),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Enter Location',
      ),
    );
  }
}
