import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';

import '../models/search.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  late RestaurantSearchResult _restaurantSearchResult;
  late ResultState _state;
  String _message = '';
  final String _query = '';

  String get message => _message;
  RestaurantSearchResult get result => _restaurantSearchResult;
  ResultState get state => _state;
  String get query => _query;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check Your Connection!';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
