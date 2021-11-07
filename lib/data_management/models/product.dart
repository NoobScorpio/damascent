class Product {
  late String pId;
  late String pname;
  late String image1;
  late String image2;
  late String image3;
  late String price;
  late String description;
  late String qty;
  late String keyword;
  late String discount;

  Product(
      {required this.pId,
      required this.pname,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.price,
      required this.description,
      required this.qty,
      required this.discount,
      required this.keyword});

  Product.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    pname = json['pname'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    price = json['price'];
    description = json['description'];
    qty = json['qty'];
    keyword = json['keyword'];
    discount = json['discount'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_id'] = pId;
    data['pname'] = pname;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['price'] = price;
    data['description'] = description;
    data['qty'] = qty;
    data['keyword'] = keyword;
    data['discount'] = discount;
    return data;
  }
}

class ProductResultModel {
  late List<Product> products;

  ProductResultModel({required this.products});

  ProductResultModel.fromJson(Map<String, dynamic> json) {
    products = <Product>[];
    json['records'].forEach((v) {
      products.add(Product.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products.map((v) => v.toJson()).toList();
    return data;
  }
}
