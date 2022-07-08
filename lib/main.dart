import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/screens/cart_screen.dart';
import 'package:flutter_hiring_challenge/screens/home_screen.dart';
import 'package:flutter_hiring_challenge/screens/splash_screen.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor:  primaryColor,
  systemNavigationBarColor:  primaryColor,
));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Apni Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        buttonColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          )
      ),
      routes: {
        "/home": (context) => HomeScreen(),
        "/cart": (context) => CartScreen()
      },
      onGenerateRoute: (route) {
        if (route.name.contains('/home'))
          return CupertinoPageRoute(
              builder: (context) => HomeScreen(), maintainState: true);
        else if (route.name.contains('/cart'))
          return CupertinoPageRoute(
              builder: (context) => CartScreen(), maintainState: true);
        else
          return null;
      },
      home: SplashScreen(),
    );
  }
}
