import 'package:meta/meta.dart';
import 'dart:convert';

class OrderItemModel {
    OrderItemModel({
        @required this.id,
        @required this.name,
        @required this.description,
        @required this.qty,
        @required this.price,
    });

    String id;
    String name;
    String description;
    int qty;
    double price;

    factory OrderItemModel.fromJson(String str) => OrderItemModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderItemModel.fromMap(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        qty: json["qty"] == null ? null : json["qty"],
        price: json["price"] == null ? null : json["price"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "qty": qty == null ? null : qty,
        "price": price == null ? null : price,
    };
}
