import 'dart:convert';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepository {
  Future<List<Product>> getAllProducts({search});
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
}
