import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hiring_challenge/models/order_item_model.dart';
import 'package:flutter_hiring_challenge/models/product_model.dart';
import 'package:flutter_hiring_challenge/providers/cart_provider.dart';
import 'package:flutter_hiring_challenge/providers/product_provider.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class CartProductScreen extends StatelessWidget {
  final ProductModel productModel;
  final OrderItemModel orderItemModel;
  const CartProductScreen(
      {@required this.orderItemModel, @required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
      children: [
        Row(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Container(
                    width: 60,
                    height: 70,
                    child: Image.network(
                      productModel.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      orderItemModel.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        orderItemModel.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs. " +
                            (orderItemModel.price * orderItemModel.qty)
                                .toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Row(
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
                                        itemId: orderItemModel.id, qty: -1);
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .updateQtyById(
                                        itemId: orderItemModel.id, qty: -1);
                              }),
                          Text(orderItemModel.qty.toString()),
                          IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  color: productModel.qty > orderItemModel.qty
                                      ? Colors.green
                                      : Colors.grey),
                              onPressed: productModel.qty <= orderItemModel.qty
                                  ? null
                                  : () {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .updateProductItem(
                                              itemId: orderItemModel.id,
                                              qty: 1);
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .updateQtyById(
                                              itemId: orderItemModel.id,
                                              qty: 1);
                                    }),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: Colors.red[500],
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: IconButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(itemId: orderItemModel.id);
                Provider.of<CartProvider>(context, listen: false)
                    .itemRemovefromCart(itemId: orderItemModel.id);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ));
    ;
  }
}
