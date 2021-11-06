import 'dart:convert';
import 'package:damascent/data_management/models/cart.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartRepository {
  Future<List<CartItem>> addItem(CartItem cartItem);
  Future<List<CartItem>> getItems();
  Future<List<CartItem>> removeItem(CartItem cartItem);
  Future<void> emptyCart();
}

class CartRepositoryImpl extends CartRepository {
  // Cart cart = Cart();
  late SharedPreferences sharedPreferences;

  CartRepositoryImpl();
  @override
  Future<List<CartItem>> addItem(CartItem cartItem) async {
    try {
      debugPrint('ADDED ITEMS');
      sharedPreferences = await SharedPreferences.getInstance();
      MyCart cart = MyCart();
      var getCart = sharedPreferences.getString('cart');
      debugPrint('GOT CART');
      if (getCart == null) {
        debugPrint('CART NULL S');
        cart.cartItem = [];
        cart.cartItem.add(cartItem);

        await sharedPreferences.setString('cart', json.encode(cart.toJson()));
        debugPrint('CART NULL E');
      } else {
        debugPrint('CART NOT NULL');
        cart = MyCart.fromJson(json.decode(getCart));
        debugPrint('BEFORE FOR');
        for (int i = 0; i < cart.cartItem.length; i++) {
          if (cartItem.product.pId == cart.cartItem[i].product.pId) {
            cart.cartItem[i].qty++;
            await sharedPreferences.setString(
                'cart', json.encode(cart.toJson()));
            return cart.cartItem;
          }
        }
        cart.cartItem.add(cartItem);
        await sharedPreferences.setString('cart', json.encode(cart.toJson()));
      }

      return cart.cartItem;
      // }
    } on Exception catch (_, e) {
      debugPrint('ADD ERROR $e');
      return [];
    }
  }

  @override
  Future<List<CartItem>> getItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var getCart = sharedPreferences.getString('cart');

    if (getCart == null) {
      return [];
    } else {
      MyCart cart = MyCart();
      cart = MyCart.fromJson(json.decode(getCart));
      return cart.cartItem;
    }
  }

  @override
  Future<List<CartItem>> removeItem(CartItem cartItem) async {
    debugPrint('IN REMOVE ITEMS');
    sharedPreferences = await SharedPreferences.getInstance();
    var getCart = sharedPreferences.getString('cart') ?? '';
    MyCart cart = MyCart();
    cart = MyCart.fromJson(json.decode(getCart));
    if (cart.cartItem.isEmpty) {
      return [];
    } else {
      for (int i = 0; i < cart.cartItem.length; i++) {
        if (cart.cartItem[i].product.pId == cartItem.product.pId) {
          if (cart.cartItem[i].qty >= 2) {
            cart.cartItem[i].qty--;
            // cart.cartItem.removeAt(i);
            await sharedPreferences.setString(
                'cart', json.encode(cart.toJson()));
            return cart.cartItem;
          } else {
            // cart.cartItem[i].qty--;
            cart.cartItem.removeAt(i);
            await sharedPreferences.setString(
                'cart', json.encode(cart.toJson()));
            return cart.cartItem;
          }
        }
      }
      return [];
    }
  }

  @override
  Future<void> emptyCart() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      MyCart cart = MyCart.fromJson({'CartItem': []});
      await sharedPreferences.setString('cart', json.encode(cart.toJson()));
      debugPrint('CART EMPTY');
    } catch (e) {
      debugPrint('$e');
    }
  }
}
