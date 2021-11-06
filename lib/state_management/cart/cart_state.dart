import 'package:damascent/data_management/models/cart_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CartState extends Equatable {}

class CartInitialState extends CartState {
  final List<CartItem> carItems;

  CartInitialState(this.carItems);
  @override
  // TODO: implement props
  List<Object> get props => [carItems];
}

class CartLoadingState extends CartState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final List<CartItem> cartItems;
  final int total, subTotal, discount;
  CartLoadedState(
      {required this.total,
      required this.subTotal,
      required this.cartItems,
      required this.discount});

  @override
  // TODO: implement props
  List<Object> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class CartItemAddedState extends CartState {
  final List<CartItem> added;
  final int total, subTotal, discount;
  CartItemAddedState(
      {required this.total,
      required this.subTotal,
      required this.added,
      required this.discount});

  @override
  // TODO: implement props
  List<Object> get props => [added];
}

class CartItemRemoveState extends CartState {
  final List<CartItem> removed;
  final int total, subTotal, discount;
  CartItemRemoveState(
      {required this.discount,
      required this.total,
      required this.subTotal,
      required this.removed});

  @override
  // TODO: implement props
  List<Object> get props => [removed];
}

class GetCartItemState extends CartState {
  final List<CartItem> cartItems;

  GetCartItemState({required this.cartItems});

  @override
  // TODO: implement props
  List<Object> get props => [cartItems];
}
