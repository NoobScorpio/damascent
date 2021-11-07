import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/data_management/repos/product_repo.dart';
import 'package:damascent/state_management/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final ProductRepository productRepository;

  WishlistCubit({required this.productRepository})
      : super(WishlistInitialState());

  Future<void> getWishlistProducts({required String id}) async {
    try {
      emit(WishlistLoadingState());
      final products = await productRepository.getWishlistProducts(id: id);
      emit(WishlistLoadedState(products: products));
    } on Exception {
      emit(WishlistErrorState(message: "Could not get product"));
    }
  }

  Future<void> addWishlistProduct(
      {required String id, required String pid}) async {
    try {
      // emit(WishlistLoadingState());
      final bool added =
          await productRepository.addWishlistProduct(id: id, pid: pid);
      if (added) {
        await getWishlistProducts(id: id);
      }
    } on Exception {
      emit(WishlistErrorState(message: "Could not get product"));
    }
  }

  Future<void> removeWishlistProduct(
      {required String id, required String pid}) async {
    try {
      // emit(WishlistLoadingState());
      final bool removed =
          await productRepository.removeWishlistProduct(id: id, pid: pid);
      if (removed) {
        await getWishlistProducts(id: id);
      }
    } on Exception {
      emit(WishlistErrorState(message: "Could not get product"));
    }
  }
}
