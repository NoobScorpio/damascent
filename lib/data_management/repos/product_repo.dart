import 'dart:convert';
import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/order.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getAllProducts({search});
  Future<List<Order>> getAllOrders({required String id});
  Future<List<Product>> getWishlistProducts({required String id});
  Future<bool> addWishlistProduct({required String id, required String pid});
  Future<bool> removeWishlistProduct({required String id, required String pid});
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getAllProducts({search}) async {
    try {
      var response = await http.get(Uri.parse(baseURL + "/products.php"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        List<Product> search = ProductResultModel.fromJson(data).products;
        debugPrint("RETURNING API PRODUCTS");
        return search;
      } else if (response.statusCode == 400) {
        return [];
      } else if (response.statusCode == 500) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      return [];
    }
  }

  static Future<int> getAgent({required String link}) async {
    try {
      var links = link.split("?");
      links = links[1].split("&");
      String agent = links[0].split("=")[1];
      // String discount = links[1].split("=")[1];
      var response = await http.get(Uri.parse(baseURL + "/agent.php"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body)['records'];
        for (var p in data) {
          if (p['agent'].toString().toLowerCase() == agent.toLowerCase()) {
            final now = DateTime.now();
            var dateStr = p['expiryDate'].toString().split("-");
            final expirationDate = DateTime(int.parse(dateStr[0]),
                int.parse(dateStr[1]), int.parse(dateStr[2]));
            final bool isExpired = expirationDate.isBefore(now);

            if (isExpired) {
              showToast("Discount is expired", Colors.red);
              return 0;
            } else {
              return int.parse(p['value']);
            }
          }
        }
        return 0;
      } else if (response.statusCode == 400) {
        return 0;
      } else if (response.statusCode == 500) {
        return 0;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS AGENT API: $e");
      return 0;
    }
  }

  static Future<int> getPromo({required String promo}) async {
    try {
      var response = await http.get(Uri.parse(baseURL + "/promo.php"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body)['records'];
        for (var p in data) {
          if (p['ProName'].toString().toLowerCase() == promo.toLowerCase()) {
            final now = DateTime.now();
            var dateStr = p['expiryDate'].toString().split("-");
            final expirationDate = DateTime(int.parse(dateStr[0]),
                int.parse(dateStr[1]), int.parse(dateStr[2]));
            final bool isExpired = expirationDate.isBefore(now);

            if (isExpired) {
              showToast("Promo code is expired", Colors.red);
              return 0;
            } else {
              return int.parse(p['value']);
            }
          }
        }
        return 0;
      } else if (response.statusCode == 400) {
        return 0;
      } else if (response.statusCode == 500) {
        return 0;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      return 0;
    }
  }

  static Future<bool> createOrder(
      {required String id,
      required int total,
      required String payment,
      required List<CartItem> items}) async {
    try {
      var time = DateTime.now().millisecondsSinceEpoch;
      var date =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      var jsonObj = {
        "OrderID": time.toString(),
        "id": id,
        "timeStamp": time.toString(),
        "status": "processing",
        "payment": payment,
        "total": "$total",
        "OrderTime": date
      };
      debugPrint(jsonObj.toString());
      var response = await http.post(Uri.parse(baseURL + "/createOrder.php"),
          body: json.encode(jsonObj));
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (var item in items) {
          await http.post(Uri.parse(baseURL + "/productOrder.php"),
              body: json.encode(
                {
                  "OrderID": time.toString(),
                  "p_id": item.product.pId,
                  "qty": item.qty.toString(),
                  "price": item.product.price
                },
              ));
        }

        return true;
      } else if (response.statusCode == 400) {
        debugPrint("400 ERROR IN PRODUCTS API: ${response.body}");
        return false;
      } else if (response.statusCode == 500) {
        debugPrint("500 ERROR IN PRODUCTS API: ${response.body}");
        return false;
      } else {
        debugPrint(
            "${response.statusCode}ERROR IN PRODUCTS API: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      return false;
    }
  }

  static Future<void> sendEmail({email}) async {
    try {
      var resp = await http
          .get(Uri.parse("https://damascent.com/shopping.php?email=" + email));
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        debugPrint(
            "EMAIL SENT : https://damascent.com/shopping.php?email=waseem.noah@gmail.com");
        debugPrint(resp.body);
        // showToast("Email registered", Constants.primaryColor);
      } else if (resp.statusCode == 400) {
        showToast(json.decode(resp.body), Constants.primaryColor);
      } else if (resp.statusCode == 500) {
        showToast(json.decode(resp.body), Constants.primaryColor);
      } else {
        showToast(json.decode(resp.body), Constants.primaryColor);
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      showToast(e.toString(), Constants.primaryColor);
    }
  }

  @override
  Future<List<Order>> getAllOrders({required String id}) async {
    try {
      var response = await http.get(Uri.parse(baseURL + "/allitem.php?id=$id"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        List<Order> search = OrderResultModel.fromJson(data).orders;
        debugPrint("RETURNING API PRODUCTS");
        return search;
      } else if (response.statusCode == 400) {
        return [];
      } else if (response.statusCode == 500) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      return [];
    }
  }

  @override
  Future<List<Product>> getWishlistProducts({required String id}) async {
    try {
      var response =
          await http.get(Uri.parse(baseURL + "/wishlist.php?id=$id"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        debugPrint("RETURNING API PRODUCTS ${data['records']}");
        List<Product> search = ProductResultModel.fromJson(data).products;
        debugPrint("RETURNING API PRODUCTS");
        return search;
      } else if (response.statusCode == 400) {
        return [];
      } else if (response.statusCode == 500) {
        return [];
      } else {
        return [];
      }
    } catch (e, _) {
      debugPrint("ERROR IN WISHLIST API: $e $_");
      return [];
    }
  }

  @override
  Future<bool> addWishlistProduct(
      {required String id, required String pid}) async {
    try {
      List<Product> prods = await getWishlistProducts(id: id);
      for (var prod in prods) {
        if (pid == prod.pId) {
          showToast("Item already added", Colors.red);
          return false;
        }
      }
      var response = await http.post(
        Uri.parse(baseURL + "/insertWishlist.php"),
        body: json.encode({"id": id, "p_id": pid}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        showToast("Item added", Colors.green);
        return true;
      } else if (response.statusCode == 400) {
        debugPrint(response.body);
        showToast("Could not add Item", Colors.green);
        return false;
      } else if (response.statusCode == 500) {
        debugPrint(response.body);
        showToast("Could not add Item", Colors.green);
        return false;
      } else {
        debugPrint(response.body);
        showToast("Could not add Item", Colors.green);
        return false;
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      showToast("Could not add Item", Colors.green);
      return false;
    }
  }

  @override
  Future<bool> removeWishlistProduct(
      {required String id, required String pid}) async {
    try {
      var response = await http.post(
        Uri.parse(baseURL + "/removeWishlist.php"),
        body: json.encode({"id": id, "p_id": pid}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        showToast("Item removed", Colors.green);
        return true;
      } else if (response.statusCode == 400) {
        debugPrint(response.body);
        showToast("Could not remove Item", Colors.green);
        return false;
      } else if (response.statusCode == 500) {
        debugPrint(response.body);
        showToast("Could not remove Item", Colors.green);
        return false;
      } else {
        debugPrint(response.body);
        showToast("Could not remove Item", Colors.green);
        return false;
      }
    } catch (e) {
      debugPrint("ERROR IN PRODUCTS API: $e");
      return false;
    }
  }
}
