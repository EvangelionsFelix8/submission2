import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';
import 'package:submission1_restaurant_app/provider/detail_restaurant_provider.dart';

import '../models/restaurant.dart';
import '../models/detail_restaurant.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  final Restaurant restaurant;

  DetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  late Future<RestaurantDetailResult> restaurantFuture;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), restaurantId: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
        ),
        body: SingleChildScrollView(
          child: Consumer<DetailRestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const SizedBox(
                  height: 800,
                  width: 500,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return Column(
                  children: [
                    Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                          ApiService.imageUrl + restaurant.pictureId),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                restaurant.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(restaurant.rating.toString()),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Text(
                                restaurant.city,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Deskripsi Restaurant",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            restaurant.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount:
                                  state.result.restaurant.categories.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    labelPadding: const EdgeInsets.all(5),
                                    label: Text(state.result.restaurant
                                        .categories[index].name),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Makanan",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              listFoodDrink(
                                listCount:
                                    state.result.restaurant.menus.foods.length,
                                harga: "Rp 16.000",
                                isFood: true,
                                menus: state.result.restaurant.menus,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Minuman",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              listFoodDrink(
                                listCount:
                                    state.result.restaurant.menus.foods.length,
                                harga: "Rp 6.000",
                                isFood: false,
                                menus: state.result.restaurant.menus,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else {
                return const Center(
                  child: Material(
                    child: Text(''),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget listFoodDrink(
      {required int listCount,
      required String harga,
      required bool isFood,
      required Menus menus}) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCount, // ini
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 204, 204, 204),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child:
                      Image.network(ApiService.imageUrl + restaurant.pictureId),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isFood
                          ? Text(menus.foods[index].name)
                          : Text(menus.drinks[index].name),
                      Text(harga), // ini
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
