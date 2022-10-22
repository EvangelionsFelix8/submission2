import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';

import '../models/restaurant.dart';
import '../screens/detail_screen.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          ApiService.imageUrl + restaurant.pictureId,
          width: 100,
        ),
      ),
      title: Text(
        restaurant.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(restaurant.city),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(restaurant.rating.toString()),
            ],
          ),
        ],
      ),
      onTap: () => Navigator.pushNamed(
        context,
        DetailScreen.routeName,
        arguments: restaurant,
      ),
    );
  }
}
