import 'package:damascent/data_management/models/cart_item.dart';

class MyCart {
  MyCart._privateConstructor();

  static final _instance = MyCart._privateConstructor();
  factory MyCart() {
    return _instance;
  }
  late List<CartItem> cartItem;

  // Cart({this.cartItem});

  MyCart.fromJson(Map<String, dynamic> json) {
    if (json['CartItem'] != null) {
      cartItem = <CartItem>[];
      json['CartItem'].forEach((v) {
        cartItem.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CartItem'] = cartItem.map((v) => v.toJson()).toList();
    return data;
  }
}
