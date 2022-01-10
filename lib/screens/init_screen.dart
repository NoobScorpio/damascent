import 'dart:convert';

import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUser();
    BlocProvider.of<CartCubit>(context).initializeCart();
    BlocProvider.of<ProductCubit>(context).getProducts();
    checkDiscount();
  }

  void checkDiscount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String discount = preferences.getString(prefAgent) ?? "";
    if (discount == "") {
      await preferences.setString(prefAgent,
          json.encode({"agent": "dummy", "discount": 5, "applied": true}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLoadedState) {
        if (state.user.id == "" || state.user.id == null) {
          return const NavigationScreen(id: "");
        }
        return NavigationScreen(id: state.user.id ?? "");
      } else {
        return const NavigationScreen(id: "");
      }
    });
  }
}
