import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hiring_challenge/models/order_item_model.dart';
import 'package:flutter_hiring_challenge/models/product_model.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/screens/cart_product_screen.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Successful Payment',
          style: TextStyle(
              color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Provider.of<CartProvider>(context).getCartItems.length > 0
          ? new Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount:
                        Provider.of<CartProvider>(context).getCartItems.length,
                    itemBuilder: (context, index) {
                      OrderItemModel orderItemModel =
                          Provider.of<CartProvider>(context)
                              .getCartItems[index];
                      var productIndex = Provider.of<ProductProvider>(context)
                          .findItemById(itemId: orderItemModel.id);
                      ProductModel productModel =
                          Provider.of<ProductProvider>(context)
                              .getProductList
                              .elementAt(productIndex);
                      return CartProductScreen(
                          orderItemModel: orderItemModel,
                          productModel: productModel);
                    },
                  ),
                )
              ],
            )
          : Container(
              height: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/no_product_found.png'),
                  Text(
                    "Sorry, no products found !",
                    style: TextStyle(color: primaryColor, fontSize: 25),
                  ),
                  Text(
                    "Please shoping now.",
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  )
                ],
              ),
            ),
      bottomNavigationBar: Provider.of<CartProvider>(context)
                  .getCartItems
                  .length >
              0
          ? BottomAppBar(
              elevation: 18,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Total Amount",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Rs " +
                                  Provider.of<CartProvider>(context)
                                      .getTotalPriceOfCart()
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: primaryColor),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onPressed: Provider.of<CartProvider>(context)
                                  .getCartItems
                                  .length >
                              0
                          ? () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .sellingProduct();
                              Provider.of<CartProvider>(context, listen: false)
                                  .clearCart();
                              showToast(context);
                            }
                          : null,
                    ))
                  ],
                ),
              ),
            )
          : null,
    ));
  }
}
