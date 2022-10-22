import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/models/detail_restaurant.dart';

import 'models/restaurant.dart';
import 'screens/detail_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
              // restaurantinDetail: ModalRoute.of(context)?.settings.arguments
              //     as RestaurantinDetail,
            ),
      },
    );
  }
}
