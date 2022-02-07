import 'package:flutter/material.dart';
import 'package:flutter_food_finder/models/restaurant.dart';
import 'package:flutter_food_finder/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {Key? key, required this.restaurant, required this.distance})
      : super(key: key);

  final Restaurant restaurant;
  final String distance;

  Widget _buildFavouritesButton(BuildContext context) {
    const double size = 36;

    return Consumer<FavouritesProvider>(
      builder: (context, favourites, child) {
        bool isFavourite =
            favourites.favourites.indexWhere((r) => r.id == restaurant.id) >= 0;

        final Widget icon = isFavourite
            ? const Icon(Icons.favorite, color: Colors.red, size: size)
            : const Icon(Icons.favorite_outline,
                color: Colors.white, size: size);

        return IconButton(
            onPressed: () => !isFavourite
                ? favourites.add(restaurant)
                : favourites.remove(restaurant),
            icon: icon);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = restaurant.imageUrl.isNotEmpty
        ? restaurant.imageUrl
        : "https://picsum.photos/id/163/400/300";

    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.44),
                                  BlendMode.dstATop),
                              image: NetworkImage(imageUrl)),
                        )),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: _buildFavouritesButton(context)),
                        Positioned(
                            top: 12,
                            right: 12,
                            child: Row(children: [
                              const Icon(
                                Icons.navigation,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "${distance}m",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(restaurant.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                                child:
                                    Rating(rating: restaurant.rating.toInt()))
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(restaurant.address)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class Rating extends StatelessWidget {
  const Rating({Key? key, required this.rating}) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: List<int>.filled(rating, 0)
            .map((e) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ))
            .toList());
  }
}
