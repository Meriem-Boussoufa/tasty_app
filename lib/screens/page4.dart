import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty/screens/cart_screen.dart';
import 'package:tasty/screens/favoris_screen.dart';
import 'package:tasty/screens/home_screen.dart';
import 'package:tasty/screens/ordered_screen.dart';
import 'package:tasty/screens/profile_screen.dart';
import '../models/cart.dart';
import 'tabnavigator.dart';

class PageFour extends StatefulWidget {
  final String phone;

  int page;

  PageFour({this.phone, this.page = -1});

  @override
  PageFourState createState() => PageFourState();

}
class PageFourState  extends State<PageFour>{

  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3","Page4","Page5"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
            children:<Widget>[
              _buildOffstageNavigator("Page1"),
              _buildOffstageNavigator("Page2"),
              _buildOffstageNavigator("Page3"),
              _buildOffstageNavigator("Page4"),
              _buildOffstageNavigator("Page5"),
            ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: IconThemeData(color: Colors.black),
          selectedItemColor: Colors.white,
          backgroundColor:Colors.orange[400] ,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.favorite_outlined,
              ),
              title: new Text('Favorite'),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child:Consumer<Cart>(builder:(context,cart,child) {
                  return Stack(
                    children:[
                      Icon(Icons.shopping_cart_outlined),
                      Positioned(
                          bottom:10,
                          left:10,
                          height:15,
                          width:15,
                          child:CircleAvatar(
                            radius:5.0,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child:Text(cart.basketitem.length.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0)),
                          )
                      ),
                    ],
                  );
                }),
              ),
              title: Text('Card'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              title: new Text('Order'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: new Text('Profil'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        phonenavigat: widget.phone,
      ),
    );
  }
}