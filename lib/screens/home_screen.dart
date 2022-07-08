import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/screens/product_screen.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shop', style: TextStyle(color: Colors.white)),
        actions: [
          cartIcon(context: context),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: new Container(
        child: new GridView.builder(
          itemCount:
              Provider.of<ProductProvider>(context).getProductList.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisExtent: 275, ),
          itemBuilder: (context, index) => Card(
            child: ProductScreen(
              productModel:
                  Provider.of<ProductProvider>(context).getProductList[index],
            ),
          ),
        ),
      ),
    ));
  }
}

cartIcon({@required BuildContext context}) => GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cart');
      },
      child: Badge(
        animationType: BadgeAnimationType.fade,
        badgeColor: Colors.green,
        badgeContent: Text(
          Provider.of<CartProvider>(context, listen: true)
              .cartItems
              .length
              .toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(
          Icons.shopping_cart,
          size: 30,
        ),
        position: BadgePosition(end: 1, top: -2),
      ),
    );
