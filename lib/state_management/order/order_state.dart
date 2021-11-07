import 'package:damascent/data_management/models/order.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {}

class OrderInitialState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadedState extends OrderState {
  final List<Order> orders;
  OrderLoadedState({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class OrderErrorState extends OrderState {
  final String message;

  OrderErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
