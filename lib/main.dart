import 'package:damascent/data_management/repos/cart_repo.dart';
import 'package:damascent/data_management/repos/product_repo.dart';
import 'package:damascent/screens/init_screen.dart';
import 'package:damascent/screens/login_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';
import 'data_management/repos/user_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
            create: (context) =>
                ProductCubit(productRepository: ProductRepositoryImpl())),
        BlocProvider<CartCubit>(
            create: (context) =>
                CartCubit(cartRepository: CartRepositoryImpl())),
        BlocProvider<UserCubit>(
            create: (context) =>
                UserCubit(userRepository: UserRepositoryImpl())),
      ],
      child: MaterialApp(
        title: Constants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryColor: primaryColor,
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              //TODO: CHANGE TO 1
              textScaleFactor: 1,
            ),
            child: child!),
        home: const InitScreen(),
      ),
    );
  }
}
