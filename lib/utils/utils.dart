import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hiring_challenge/models/order_item_model.dart';
import 'package:flutter_hiring_challenge/models/product_model.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/utils/productDatas.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String PREFS_PRODUCTS_KEY = 'PRODUCTS';
final String PREFS_CARTS_KEY = 'CARTS';

final Color primaryColor = Color(0xfff59842);
final Color primaryBackgroundColor = Color(0xfff7dfc8);

saveForCart({@required List<OrderItemModel> cartItems}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String carts = json.encode({
    "carts": cartItems == null
        ? null
        : List<dynamic>.from(cartItems.map((x) => x.toMap()))
  });
  await prefs.setString(PREFS_CARTS_KEY, carts);
}

fetchForCart({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cartStr = prefs.getString(PREFS_CARTS_KEY);
  if (cartStr != null) {
    var carts = json.decode(cartStr);
    Provider.of<CartProvider>(context, listen: false).addAllOrders(
        carts["carts"] == null
            ? []
            : List<OrderItemModel>.from(
                carts["carts"].map((x) => OrderItemModel.fromMap(x))));
  }
}

saveForProducts({@required List<ProductModel> productList}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ProductListModel productListModel =
      new ProductListModel(productList: productList);
  await prefs.setString(PREFS_PRODUCTS_KEY, productListModel.toJson());
}

fetchForProducts({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String products = prefs.getString(PREFS_PRODUCTS_KEY);
  if (products != null) {
    Provider.of<ProductProvider>(context, listen: false)
        .addAllProduct(ProductListModel.fromJson(products).productList);
  } else {
    Provider.of<ProductProvider>(context, listen: false)
        .addAllProduct(ProductListModel.fromMap(productListData).productList);
  }
}
