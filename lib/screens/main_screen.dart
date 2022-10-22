import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../models/restaurant.dart';
import '../provider/restaurant_provider.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/platform_widget.dart';

class MainScreen extends StatelessWidget {
  // late Future<RestaurantResult> _restaurant, _restaurantSearch;
  // bool isSearchActive = false;

  MainScreen({Key? key}) : super(key: key);
  final _controllerSearch = TextEditingController();
  // late String value = '';
  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return SingleChildScrollView(
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
                          onPressed: () {},
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
                      Container(
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
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  },
                ),
              ],
            ),
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
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 250,
  //             width: double.infinity,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 Container(
  //                   alignment: Alignment.topRight,
  //                   child: IconButton(
  //                     padding: const EdgeInsets.all(16),
  //                     onPressed: () {
  //                       setState(() {
  //                         isSearchActive = !isSearchActive;
  //                       });
  //                     },
  //                     icon: const Icon(
  //                       Icons.search,
  //                       size: 38,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.all(8),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: const [
  //                       Text(
  //                         'Restaurant',
  //                         style: TextStyle(
  //                           fontSize: 32,
  //                         ),
  //                       ),
  //                       Text(
  //                         'Recommended Restaurant for You',
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 16,
  //                 ),
  //                 isSearchActive
  //                     ? Container(
  //                         margin: const EdgeInsets.only(right: 16, left: 16),
  //                         child: TextField(
  //                           controller: _controllerSearch,
  //                           decoration: const InputDecoration(
  //                             prefixIcon: Icon(Icons.search),
  //                             hintText: "Search Restaurant",
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(8),
  //                               ),
  //                             ),
  //                           ),
  //                           // onChanged: (value) => setState(() {
  //                           //   updateList(value);
  //                           // }),
  //                           onChanged: updateList,
  //                         ),
  //                       )
  //                     : const Text('')
  //               ],
  //             ),
  //           ),
  //           FutureBuilder(
  //             future: _restaurant,
  //             builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
  //               var state = snapshot.connectionState;
  //               if (state != ConnectionState.done) {
  //                 return const Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               } else {
  //                 if (snapshot.hasData) {
  //                   return ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: snapshot.data?.count,
  //                     itemBuilder: (context, index) {
  //                       var restaurant = snapshot.data?.restaurants[index];
  //                       return CardRestaurant(
  //                         restaurant: restaurant!,
  //                       );
  //                     },
  //                   );
  //                 } else if (snapshot.hasError) {
  //                   return Center(
  //                     child: Material(
  //                       child: Text(snapshot.error.toString()),
  //                     ),
  //                   );
  //                 } else {
  //                   return const Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 }
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
