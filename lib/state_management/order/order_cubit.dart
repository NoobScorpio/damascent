import 'package:damascent/data_management/repos/product_repo.dart';
import 'package:damascent/state_management/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final ProductRepository productRepository;

  OrderCubit({required this.productRepository}) : super(OrderInitialState());

  Future<void> getOrders({required String id}) async {
    try {
      emit(OrderLoadingState());
      final orders = await productRepository.getAllOrders(id: id);
      emit(OrderLoadedState(orders: orders));
    } on Exception {
      emit(OrderErrorState(message: "Could not get product"));
    }
  }
}
