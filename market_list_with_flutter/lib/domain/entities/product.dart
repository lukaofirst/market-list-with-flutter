// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final int id;
  final String name;
  int quantity;
  bool picked = false;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    this.picked = false,
  });

  void wasPicked() => picked = true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'picked': picked,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      picked: map['picked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Product(id: $id, name: $name, quantity: $quantity), picked: $picked';
}
