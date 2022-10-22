import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'models/restaurant.dart';
import 'provider/restaurant_provider.dart';
import 'screens/detail_screen.dart';
import 'screens/home_page.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: MainScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailScreen.routeName: (context) => DetailScreen(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
                // restaurantinDetail: ModalRoute.of(context)?.settings.arguments
                //     as RestaurantinDetail,
              ),
        },
      ),
    );
  }
}
