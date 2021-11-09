import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/checkout_screen.dart';
import 'package:damascent/screens/login_screen.dart';
import 'package:damascent/screens/profile_screen.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/cart/cart_state.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool empty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              getHeader(context: context, back: false, text: "Cart"),
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                if (state is CartLoadedState) {
                  if (state.cartItems.isEmpty) {
                    return emptyCart();
                  }

                  return cartPageWidgets(state.cartItems, state.total);
                } else if (state is CartItemAddedState) {
                  if (state.added.isEmpty) {
                    return emptyCart();
                  }

                  return cartPageWidgets(state.added, state.total);
                } else if (state is CartItemRemoveState) {
                  if (state.removed.isEmpty) {
                    return emptyCart();
                  }

                  return cartPageWidgets(state.removed, state.total);
                }
                return emptyCart();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget cartPageWidgets(List<CartItem> cartItems, total) {
    return Column(
      children: [
        ListView.builder(
          itemCount: cartItems.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ProductWidgetCart(
                cartItem: cartItems[index],
                product: cartItems[index].product,
                qty: cartItems[index].qty,
              ),
              // child: SizedBox(),
            );
          },
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Detail",
                        style: Constants.avgStyleAltBold,
                      ),
                      const SizedBox(),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cartItems[index].product.pname,
                                    style: Constants.priceStyleAlt,
                                  ),
                                  Text(
                                    "\$${cartItems[index].product.price} x ${cartItems[index].qty}",
                                    style: Constants.priceStyleAlt,
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.2,
                              )
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total ",
                            style: Constants.avgStyleAltBold,
                          ),
                          Text(
                            "(${cartItems.length} items)",
                            style: Constants.priceStyleAlt,
                          ),
                        ],
                      ),
                      Text(
                        "\$$total",
                        style: Constants.avgStyleAltBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        BlocBuilder<UserCubit, UserState>(builder: (context, ustate) {
          return InkWell(
            onTap: () {
              if (ustate is UserLoadedState) {
                if (ustate.user.id == "" || ustate.user.id == null) {
                  showToast("Not logged in", Colors.red);
                  push(context, const LoginScreen(other: true));
                } else {
                  push(
                      context,
                      CheckoutScreen(
                        total: total,
                        cartItems: cartItems,
                      ));
                }
              } else {
                showToast("Not logged in", Colors.red);
                push(context, const LoginScreen(other: true));
              }
            },
            child: Center(
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                // width: 75,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delivery_dining),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Choose Delivery Services",
                                style: Constants.avgStyleBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          width: 1,
                          height: 35,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          // width: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
