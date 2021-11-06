import 'dart:convert';
import 'package:damascent/data_management/models/cart.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/repos/cart_repo.dart';
import 'package:damascent/state_management/cart/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  late SharedPreferences sp;
  CartCubit({required this.cartRepository}) : super(CartInitialState(const []));

  Future<bool> addItem(CartItem cartItem) async {
    try {
      int sub = 0, total = 0, discount = 0;
      List<CartItem> added = await cartRepository.addItem(cartItem);
      sp = await SharedPreferences.getInstance();

      if (added.isNotEmpty) {
        for (CartItem cartItem in added) {
          sub += int.parse(cartItem.product.price) * cartItem.qty;

          discount += (int.parse(cartItem.product.discount) /
                  100 *
                  int.parse(cartItem.product.price))
              .toInt();
        }
        total = sub;
      }
      emit(CartItemAddedState(
          added: added, total: total, subTotal: sub, discount: discount));
      emit(CartLoadedState(
          cartItems: added, total: total, subTotal: sub, discount: discount));
      return added.isEmpty ? false : true;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<bool> removeItem(CartItem cartItem) async {
    try {
      int sub = 0, total = 0, discount = 0;
      List<CartItem> removed = await cartRepository.removeItem(cartItem);
      sp = await SharedPreferences.getInstance();

      if (removed.isNotEmpty) {
        for (CartItem cartItem in removed) {
          sub += int.parse(cartItem.product.price) * cartItem.qty;
        }
        total = sub;
      }
      emit(CartItemRemoveState(
          removed: removed, total: total, subTotal: sub, discount: discount));
      emit(CartLoadedState(
          cartItems: removed, total: total, subTotal: sub, discount: discount));
      return removed.isEmpty ? true : false;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return false;
    }
  }

  Future<List<CartItem>> getItems() async {
    try {
      int sub = 0, total = 0;
      List<CartItem> cartItems = await cartRepository.getItems();
      sp = await SharedPreferences.getInstance();

      if (cartItems.isNotEmpty) {
        for (CartItem cartItem in cartItems) {
          sub += int.parse(cartItem.product.price) * cartItem.qty;
        }
        total = sub;
      }
      emit(CartLoadedState(
          cartItems: cartItems, subTotal: sub, total: total, discount: 0));
      return cartItems;
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
      return [];
    }
  }

  Future<void> emptyCart() async {
    try {
      int sub = 0, total = 0;
      await cartRepository.emptyCart();

      emit(CartLoadedState(
          cartItems: const [], subTotal: sub, total: total, discount: 0));
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
    }
  }

  Future<void> initializeCart() async {
    try {
      sp = await SharedPreferences.getInstance();
      MyCart cart = MyCart();
      var getCart = sp.getString('cart');
      debugPrint("INITILIZING CART");
      if (getCart == null) {
        debugPrint("NULL CART");
        emit(CartLoadedState(
            cartItems: const [], subTotal: 0, total: 0, discount: 0));
      } else {
        debugPrint("FILLED CART");
        cart = MyCart.fromJson(json.decode(getCart));
        int sub = 0, discount = 0;
        if (cart.cartItem.isNotEmpty) {
          debugPrint("NOT EMPTY CART");
          for (CartItem cartItem in cart.cartItem) {
            debugPrint("CART ITEM ${cartItem.product.pId}");
            sub += int.parse(cartItem.product.price) * cartItem.qty;

            discount += (int.parse(cartItem.product.discount) /
                    100 *
                    int.parse(cartItem.product.price))
                .toInt();
          }
          debugPrint("EMIT NOT EMPTY CART");
          emit(CartLoadedState(
              cartItems: cart.cartItem,
              subTotal: sub,
              total: sub,
              discount: discount));
        } else {
          debugPrint("EMIT EMPTY CART");
          emit(CartLoadedState(
              cartItems: const [], subTotal: 0, total: 0, discount: 0));
        }
      }
    } on Exception {
      emit(CartErrorState(message: "Could not add item"));
    }
  }
}
