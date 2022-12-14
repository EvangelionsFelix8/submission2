import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';
import 'package:submission1_restaurant_app/models/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant(restaurantId);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(restaurantId);
      if (restaurant.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurant;
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
