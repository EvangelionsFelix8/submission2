import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/api/api_service.dart';

import '../models/restaurant.dart';
import '../widgets/card_restaurant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<RestaurantResult> _restaurant, _restaurantSearch;
  bool isSearchActive = false;
  final _controllerSearch = TextEditingController();
  List<RestaurantResult> restaurants = [];
  // late String value = '';

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().listRestaurant();
    // _restaurantSearch = ApiService().searchRestaurant('');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Restaurant"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: const EdgeInsets.all(16),
                      onPressed: () {
                        setState(() {
                          isSearchActive = !isSearchActive;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 38,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Restaurant',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'Recommended Restaurant for You',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  isSearchActive
                      ? Container(
                          margin: const EdgeInsets.only(right: 16, left: 16),
                          child: TextField(
                            controller: _controllerSearch,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search Restaurant",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            // onChanged: (value) => setState(() {
                            //   updateList(value);
                            // }),
                            onChanged: updateList,
                          ),
                        )
                      : const Text('')
                ],
              ),
            ),
            FutureBuilder(
              future: _restaurant,
              builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
                var state = snapshot.connectionState;
                if (state != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.count,
                      itemBuilder: (context, index) {
                        var restaurant = snapshot.data?.restaurants[index];
                        return CardRestaurant(
                          restaurant: restaurant!,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Material(
                        child: Text(snapshot.error.toString()),
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
          ],
        ),
      ),
    );
  }

  void updateList(String value) {
    FutureBuilder(
      // future: _restaurantSearch,
      future: ApiService().searchRestaurant(value),
      builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.count,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return CardRestaurant(
                  restaurant: restaurant!,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
