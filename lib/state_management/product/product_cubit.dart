import 'package:damascent/data_management/repos/product_repo.dart';
import 'package:damascent/state_management/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository})
      : super(ProductInitialState());

  Future<void> getProducts() async {
    try {
      emit(ProductLoadingState());
      final product = await productRepository.getAllProducts();
      emit(ProductLoadedState(products: product));
    } on Exception {
      emit(ProductErrorState(message: "Could not get product"));
    }
  }
}
