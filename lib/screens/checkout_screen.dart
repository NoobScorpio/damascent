import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/screens/address_select.dart';
import 'package:damascent/screens/payment_select.dart';
import 'package:damascent/screens/personal_info.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.cartItems, required this.total})
      : super(key: key);
  final List<CartItem> cartItems;
  final int total;
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadedState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const BackButton(),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                        "Checkout",
                        style: Constants.bigStyleAlt,
                      ))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //SHIPPING
                  InkWell(
                    onTap: () {
                      push(
                          context,
                          PersonalInformation(
                            user: state.user,
                            checkOut: true,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping address",
                            style: Constants.avgStyleAltBold,
                          ),
                          const Text(
                            "Change",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.user.fName} ${state.user.lName}",
                              style: Constants.avgStyleAltBold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${state.user.address}, ${state.user.address1}, '
                              '${state.user.state}, ${state.user.city}, ${state.user.country}',
                              style: Constants.priceStyleAlt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //PAYMENT
                  InkWell(
                    onTap: () {
                      push(context, const PaymentSelectScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment",
                            style: Constants.avgStyleAltBold,
                          ),
                          const Text(
                            "Change",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment",
                              style: Constants.avgStyleAltBold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.credit_card_outlined,
                                    size: 30,
                                  ),
                                ),
                                Text("**** **** **** 3231",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Raleway')),
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
                  //DELIVERY
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery method",
                          style: Constants.avgStyleAltBold,
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.orangeAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Standard",
                                  style: Constants.avgStyleAlt,
                                ),
                              ],
                            ),
                            Text(
                              "\$20.23",
                              style: Constants.priceStyleAlt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //PROMO
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: Text(
                      "Apply promo code",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Xedwfwe4W4S",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              'apply',
                              style: Constants.avgStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //SUMMARY
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order",
                          style: Constants.priceStyleAlt,
                        ),
                        Text(
                          "\$200",
                          style: Constants.avgStyleAltBold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: Constants.priceStyleAlt,
                        ),
                        Text(
                          "\$20",
                          style: Constants.avgStyleAltBold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Summary",
                          style: Constants.priceStyleAlt,
                        ),
                        Text(
                          "\$220",
                          style: Constants.avgStyleAltBold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //BUTTON
                  Center(
                    child: Container(
                      width: 250,
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Submit order",
                                    style: Constants.avgStyleBold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 35,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        } else {
          return buildLoading();
        }
      }),
    );
  }
}
