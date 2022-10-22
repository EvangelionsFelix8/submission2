import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';

import '../models/restaurant.dart';
import '../models/detail_restaurant.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail_screen';

  final Restaurant restaurant;
  // final RestaurantinDetail restaurantinDetail;

  const DetailScreen({
    Key? key,
    required this.restaurant,
    // required this.restaurantinDetail,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<RestaurantDetailResult> restaurantFuture;
  // late RestaurantinDetail restaurantinDetail;

  @override
  void initState() {
    super.initState();
    restaurantFuture = ApiService().getDetailRestaurant(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: restaurantFuture,
          builder: (context, AsyncSnapshot<RestaurantDetailResult> snapshot) {
            var state = snapshot.connectionState;
            if (state != ConnectionState.done) {
              return Container(
                  height: 800,
                  width: 500,
                  child: Center(child: CircularProgressIndicator()));
            } else {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Hero(
                      tag: widget.restaurant.pictureId,
                      child: Image.network(
                          ApiService.imageUrl + widget.restaurant.pictureId),
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
                                widget.restaurant.name,
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
                                  Text(widget.restaurant.rating.toString()),
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
                                widget.restaurant.city,
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
                            widget.restaurant.description,
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
                                  snapshot.data!.restaurant.categories.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    labelPadding: const EdgeInsets.all(5),
                                    label: Text(snapshot.data!.restaurant
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
                                listCount: snapshot
                                    .data!.restaurant.menus.foods.length,
                                harga: "Rp 16.000",
                                isFood: true,
                                menus: snapshot.data!.restaurant.menus,
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
                                listCount: snapshot
                                    .data!.restaurant.menus.foods.length,
                                harga: "Rp 6.000",
                                isFood: false,
                                menus: snapshot.data!.restaurant.menus,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Material(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
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
                  child: Image.network(
                      ApiService.imageUrl + widget.restaurant.pictureId),
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
