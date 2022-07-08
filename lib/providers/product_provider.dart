import 'package:flutter/cupertino.dart';
import 'package:flutter_hiring_challenge/models/product_model.dart';
import 'package:flutter_hiring_challenge/utils/utils.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> get getProductList => productList;

  int get productListLength => productList.length;

  void addAllProduct(List<ProductModel> products) {
    productList.addAll(products);
    notifyListeners();
  }

  void updateProductItem({@required String itemId, @required int qty}) {
    int index = findItemById(itemId: itemId);
    if (index != -1) {
      ProductModel productModel = productList.elementAt(index);
      productModel.setSelling(productModel.getSelling + qty);
    }
    saveForProducts(productList: productList);
    notifyListeners();
  }

  int findItemById({@required String itemId}) {
    int i = productList.indexWhere((element) {
      return element.id == itemId;
    });

    return i;
  }

  void deleteProduct({@required String itemId}) {
    int index = findItemById(itemId: itemId);
    if (index != -1) {
      ProductModel productModel = productList.elementAt(index);
      productModel.setSelling(0);
    }
    saveForProducts(productList: productList);
    notifyListeners();
  }

  void sellingProduct() {
    for (var product in this.productList) {
      if (product.getSelling > 0) {
        product.qty = product.qty - product.selling;
        product.selling = 0;
      }
    }
    saveForProducts(productList: productList);
    notifyListeners();
  }
}
