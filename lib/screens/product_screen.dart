import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hiring_challenge/models/order_item_model.dart';
import 'package:flutter_hiring_challenge/models/product_model.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductScreen({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      productModel.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              productModel.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                child: Text(
                  productModel.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rs " + productModel.price.toStringAsFixed(2),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            ),
            productModel.selling > 0
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .updateProductItem(
                                      itemId: productModel.id, qty: -1);
                              Provider.of<CartProvider>(context, listen: false)
                                  .updateQtyById(
                                      itemId: productModel.id, qty: -1);
                            }),
                        Text(productModel.selling.toString()),
                        IconButton(
                            icon: Icon(Icons.add_circle_outline,
                                color: productModel.qty > productModel.selling
                                    ? Colors.green
                                    : Colors.grey),
                            onPressed: productModel.qty > productModel.selling
                                ? () {
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .updateProductItem(
                                            itemId: productModel.id, qty: 1);
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .updateQtyById(
                                            itemId: productModel.id, qty: 1);
                                  }
                                : null),
                      ],
                    ),
                  )
                : Center(
                    child: productModel.qty > 0
                        ? TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: productModel.qty > 0
                                ? () {
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .updateProductItem(
                                            itemId: productModel.id, qty: 1);
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .itemAdd(
                                            itemOrderModel: new OrderItemModel(
                                                id: productModel.id,
                                                name: productModel.name,
                                                description:
                                                    productModel.description,
                                                qty: 1,
                                                price: productModel.price));
                                  }
                                : null,
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15),
                            child: Text(
                              'Not Available',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  )
          ],
        ),
      ),
    );
  }
}
