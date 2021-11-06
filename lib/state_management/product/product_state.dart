import 'package:damascent/data_management/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  ProductLoadedState({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
