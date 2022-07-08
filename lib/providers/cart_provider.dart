import 'package:flutter/cupertino.dart';
import 'package:flutter_hiring_challenge/models/order_item_model.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';

class CartProvider extends ChangeNotifier {
  List<OrderItemModel> cartItems = [];
  List<OrderItemModel> get getCartItems => cartItems;

   void addAllOrders(List<OrderItemModel> orders) {
    cartItems.addAll(orders);
    notifyListeners();
  }

  int get cartItemsLength => cartItems.length;
  void itemAdd({OrderItemModel itemOrderModel}) async {
    cartItems.add(itemOrderModel);
   saveForCart(cartItems: cartItems);
    notifyListeners();
  }

  void itemRemovefromCart({@required String itemId}) async {
    int index = findItemById(itemId: itemId);
    if (index != -1) {
      cartItems.removeAt(index);
    }
    saveForCart(cartItems: cartItems);

    notifyListeners();
  }

  int findItemById({@required String itemId}) {
    int i = cartItems.indexWhere((element) {
      return element.id == itemId;
    });

    return i;
  }

  int getQty({@required String itemId}) {
    int index = findItemById(itemId: itemId);
    if (index != -1) {
      return cartItems[index].qty;
    }
    return 0;
  }

  void updateQtyById({@required String itemId, @required int qty}) async {
    int index = findItemById(itemId: itemId);
    if (index != -1) {
      if (cartItems[index].qty + qty > 0) {
        cartItems[index].qty += qty;
      } else
        cartItems.removeAt(index);
    }
    saveForCart(cartItems: cartItems);
    notifyListeners();
  }

  void clearCart() async{
    cartItems.clear();
    saveForCart(cartItems: cartItems);
    notifyListeners();
  }

  double getTotalPriceOfCart() {
    double total = 0.0;
    if (cartItems.length > 0)
      for (int i = 0; i < cartItems.length; i++) {
        total += (cartItems[i].price * cartItems[i].qty);
      }
    return total;
  }
}
