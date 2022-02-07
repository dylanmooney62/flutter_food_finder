import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:flutter_food_finder/providers/restaurant_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  List<Marker> _buildMarkers(BuildContext context) {
    return context
        .watch<RestaurantProvider>()
        .restaurants
        .map((Restaurant restaurant) {
      double lat = restaurant.coordinates['latitude'];
      double lng = restaurant.coordinates['longitude'];

      return Marker(
          width: 42,
          height: 42,
          point: LatLng(lat, lng),
          builder: (context) => Row(
                children: const [
                  Icon(
                    Icons.room,
                    size: 42,
                    color: Colors.red,
                  ),
                ],
              ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var location = context.watch<LocationProvider>().location;

    if (location == null) {
      return const Text("Could not load map data");
    }

    return FlutterMap(
      key: UniqueKey(),
      options: MapOptions(
        center: LatLng(location.latitude, location.longitude),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.maptiler.com/maps/bright/{z}/{x}/{y}.png?key=${dotenv.env['MAP_TILER_KEY']}",
        ),
        MarkerLayerOptions(markers: _buildMarkers(context)),
      ],
    );
  }
}
