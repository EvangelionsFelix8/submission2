import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
// import '../provider/restaurant_provider.dart';
import '../provider/search_provider.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/platform_widget.dart';

class SearchPage extends StatefulWidget {
  static const String searchTitle = 'Search Restaurant';

  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controllerSearch = TextEditingController();

  String textvalue = ' ';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SearchPage.searchTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(SearchPage.searchTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(textvalue),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
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
              onChanged: (value) {
                setState(() {
                  textvalue = value;
                  ChangeNotifierProvider<SearchProvider>(
                    create: (_) =>
                        SearchProvider(apiService: ApiService(), query: value),
                    child: Consumer<SearchProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultState.loading) {
                          print("MASUK INI");
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultState.hasData) {
                          print("MASUK INI");
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.result.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = state.result.restaurants[index];
                              return CardRestaurant(
                                restaurant: restaurant,
                              );
                            },
                          );
                        } else if (state.state == ResultState.noData) {
                          print("MASUK INI");
                          return Center(
                            child: Material(
                              child: Text(state.message),
                            ),
                          );
                        } else if (state.state == ResultState.error) {
                          print("MASUK INI");
                          return Center(
                            child: Material(
                              child: Text(state.message),
                            ),
                          );
                        } else {
                          print("MASUK INI");
                          return const Center(
                            child: Material(
                              child: Text(''),
                            ),
                          );
                        }
                      },
                    ),
                  );
                });

                // showDialog<void>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: const Text('That is correct!'),
                //       content: const Text('13 is the right answer.'),
                //       actions: <Widget>[
                //         TextButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           child: const Text('OK'),
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  void updateList(String value) {
    textvalue = value;
  }
}
