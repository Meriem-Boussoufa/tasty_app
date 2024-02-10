import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'screens/page1.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    MyApp(),
  );
}

// ?
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: Builder(
        builder: (BuildContext context) => Consumer<Cart>(
          builder: (context, card, widget) {
            return MaterialApp(
              title: 'Food Delivery UI',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[50],
                primaryColor: Colors.deepOrangeAccent,
              ),
              home: PageOne(),
            );
          },
        ),
      ),
    );
  }
}
