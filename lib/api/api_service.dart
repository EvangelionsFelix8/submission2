import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/detail_restaurant.dart';
import '../models/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String imageUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const String getRestaurantById =
      "https://restaurant-api.dicoding.dev/detail/";
  static const String searchByName =
      "https://restaurant-api.dicoding.dev/search";

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Restaurant');
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(getRestaurantById + id));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Detail Restaurant');
    }
  }

  Future<RestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$searchByName?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load List Restaurant');
    }
  }
}
