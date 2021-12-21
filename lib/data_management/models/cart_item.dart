import 'package:damascent/data_management/models/product.dart';

class CartItem {
  late int qty;
  late Product product;

  CartItem({
    required this.qty,
    required this.product,
  });
  CartItem.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    // debugPrint('CART ITEM ${json['product']}');
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['product'] = product;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product == other.product;

  @override
  int get hashCode => product.hashCode + qty.hashCode;

  List<Object> get props => throw UnimplementedError();
}
