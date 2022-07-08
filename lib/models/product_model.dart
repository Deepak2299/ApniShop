import 'package:meta/meta.dart';
import 'dart:convert';

class ProductModel {
  ProductModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.qty,
      @required this.imageUrl,
      this.selling = 0});

  String id;
  String name;
  String description;
  dynamic price;
  int qty;
  String imageUrl;
  int selling;

  int get getSelling => selling;

  void setSelling(int _selling) {
    selling = _selling;
  }

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        qty: json["qty"] == null ? null : json["qty"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        selling: json["selling"] == null ? 0 : json["selling"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "qty": qty == null ? null : qty,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "selling": selling == null ? 0 : selling,
      };
}

class ProductListModel {
    ProductListModel({
        @required this.productList,
    });

    List<ProductModel> productList;

    factory ProductListModel.fromJson(String str) => ProductListModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductListModel.fromMap(Map<String, dynamic> json) => ProductListModel(
        productList: json["productList"] == null ? null : List<ProductModel>.from(json["productList"].map((x) => ProductModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "productList": productList == null ? null : List<dynamic>.from(productList.map((x) => x.toMap())),
    };
}