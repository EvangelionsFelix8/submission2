import 'dart:convert';

import 'package:submission1_restaurant_app/models/restaurant.dart';

RestaurantSearchResult restaurantSearchResultFromJson(String str) =>
    RestaurantSearchResult.fromJson(json.decode(str));

class RestaurantSearchResult {
  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class RestaurantinSearch {
  RestaurantinSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory RestaurantinSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantinSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
