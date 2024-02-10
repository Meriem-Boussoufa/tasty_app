import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'favoris_screen.dart';
import 'home_screen.dart';
import 'ordered_screen.dart';
import 'profile_screen.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem,this.phonenavigat});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final String phonenavigat;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Page1")
      child = HomeScreen(phoned: phonenavigat);
    else if(tabItem == "Page2")
      child = FavorisScreen();
    else if(tabItem == "Page3")
      child = CartScreen(phoned: phonenavigat);
    else if(tabItem == "Page4")
      child = OrderedScreen(phoned: phonenavigat);
    else if(tabItem == "Page5")
      child = ProfileScreen(phoned: phonenavigat);

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}