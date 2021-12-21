import 'package:damascent/data_management/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {}

class WishlistInitialState extends WishlistState {
  @override
  List<Object> get props => [];
}

class WishlistLoadingState extends WishlistState {
  @override
  List<Object> get props => [];
}

class WishlistLoadedState extends WishlistState {
  final List<Product> products;
  WishlistLoadedState({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class WishlistErrorState extends WishlistState {
  final String message;

  WishlistErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
