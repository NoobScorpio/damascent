class Order {
  late String oid;
  late String date;
  late String total;
  late String status;

  Order({
    required this.oid,
    required this.date,
    required this.total,
    required this.status,
  });

  Order.fromJson(Map<String, dynamic> json) {
    oid = json['OrderID'];
    date = json['OrderTime'];
    total = json['total'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderID'] = oid;
    data['OrderTime'] = date;
    data['total'] = total;
    data['status'] = status;
    return data;
  }
}

class OrderResultModel {
  late List<Order> orders;

  OrderResultModel({required this.orders});

  OrderResultModel.fromJson(Map<String, dynamic> json) {
    orders = <Order>[];
    json['records'].forEach((v) {
      orders.add(Order.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders.map((v) => v.toJson()).toList();
    return data;
  }
}
