import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

showLoader(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.transparent,
    builder: (_) => Center(
      child: Image.asset(
        "assets/loading.gif",
        scale: 2,
      ),
    ),
  );
}

void showToast(String msg, Color color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

void addToCart({required Product product, context}) async {
  if (int.parse(product.qty) == 0) {
    showToast("Product out of stock", Constants.primaryColor);
  } else {
    showToast("Adding product", Constants.primaryColor);
    // SharedPreferences sp = await SharedPreferences.getInstance();

    // bool? loggedIn = sp.getBool('loggedIn');
    // if (loggedIn == null || loggedIn == false) {
    //   showToast("Not logged in", Constants.primaryColor);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (_) => AccountsLoginScreen(
    //                 product: true,
    //                 view: true,
    //               )));
    // } else {
    //   var user = User.fromJson(json.decode(sp.getString('user')));
    // if (user != null && user.id != null) {
    // if (int.parse(qtySelected.split(' ')[1]) > product.quantity) {
    //   showToast('Product quantity not available', Colors.red);
    // } else {
    var cartItem = CartItem.fromJson({'product': product.toJson(), 'qty': 1});

    bool added = await BlocProvider.of<CartCubit>(context).addItem(cartItem);
    if (added) {
      showToast("Product Added to cart", Constants.primaryColor);
    } else {
      showToast('Could not add to cart', Constants.primaryColor);
    }
    // }
    // } else {
    //   showToast("You are not logged in", primaryColor);
    // }
    // }
  }
}
