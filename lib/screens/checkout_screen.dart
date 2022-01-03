import 'dart:convert';

import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/data_management/repos/product_repo.dart';
import 'package:damascent/data_management/repos/user_repo.dart';
import 'package:damascent/screens/payment_screen.dart';
import 'package:damascent/screens/payment_select.dart';
import 'package:damascent/screens/personal_info.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {Key? key,
      required this.cartItems,
      required this.total,
      required this.log})
      : super(key: key);
  final List<CartItem> cartItems;
  final int total;
  final bool log;
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int group = 2;
  bool promo = false;
  int discount = 0;
  late int total;
  bool filled = false;
  MyUser user = MyUser();
  TextEditingController promoCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    total = widget.total;
    if (!widget.log) {
      checkGuestUser();
    }
  }

  checkGuestUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String str = sp.getString('guest') ?? "";
    if (str != "") {
      setState(() {
        user = MyUser.fromJson(json.decode(str));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: widget.log
            ? getBlocWidget()
            : SafeArea(
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
                        onTap: () async {
                          showLoader(context);
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          String getString = sp.getString('guest') ?? "";
                          MyUser guest = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PersonalInformation(
                                        user: getString == ""
                                            ? user
                                            : MyUser.fromJson(
                                                json.decode(getString)),
                                        checkOut: true,
                                        log: false,
                                      )));
                          if (guest.id != "0") {
                            setState(() {
                              user = guest;
                            });
                          }
                          pop(context);
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
                                  (user.fName == null || user.fName == "")
                                      ? "Guest User"
                                      : "${user.fName} ${user.lName}",
                                  style: Constants.avgStyleAltBold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  (user.address == null || user.address == "")
                                      ? "Please add address"
                                      : '${user.address}, ${user.address1}, '
                                          '${user.state}, ${user.city}, ${user.country}',
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
                        onTap: () async {
                          int g = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PaymentSelectScreen(
                                        group: group,
                                      )));
                          setState(() {
                            group = g;
                          });
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
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        group == 0
                                            ? FontAwesomeIcons.cashRegister
                                            : (group == 1
                                                ? FontAwesomeIcons.creditCard
                                                : FontAwesomeIcons.paypal),
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                        group == 0
                                            ? "Cash on Delivery"
                                            : (group == 1
                                                ? "Credit/Debit Card"
                                                : "Paypal"),
                                        style: const TextStyle(
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
                            const SizedBox(),
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
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.orangeAccent,
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
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
                                  "0.0",
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: TextField(
                                  controller: promoCont,
                                  decoration: InputDecoration(
                                      hintText: "Xedwfwe4W4S",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                showLoader(context);
                                if (promo) {
                                  showToast("Promo already applied",
                                      Constants.primaryColor);
                                } else {
                                  showToast(
                                      "Applying promo", Constants.primaryColor);
                                  int p = await ProductRepositoryImpl.getPromo(
                                      promo: promoCont.text);
                                  if (p == 0) {
                                    showToast("Promo code not valid",
                                        Constants.primaryColor);
                                  } else {
                                    setState(() {
                                      total = (widget.total -
                                              (widget.total * (p / 100)))
                                          .toInt();
                                      discount =
                                          (widget.total * (p / 100)).toInt();
                                      promo = true;
                                      // debugPrint((total - (total * (p / 100)))
                                      //     .toInt()
                                      //     .toString());
                                    });
                                    showToast("Promo applied",
                                        Constants.primaryColor);
                                  }
                                }
                                pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Center(
                                  child: Text(
                                    'apply',
                                    style: Constants.avgStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //SUMMARY
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order",
                              style: Constants.priceStyleAlt,
                            ),
                            Text(
                              "£${widget.total}",
                              style: Constants.avgStyleAltBold,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 25, vertical: 8),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Delivery",
                      //         style: Constants.priceStyleAlt,
                      //       ),
                      //       Text(
                      //         "£20",
                      //         style: Constants.avgStyleAltBold,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (promo)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Promo discount",
                                style: Constants.priceStyleAlt,
                              ),
                              Text(
                                "- £$discount",
                                style: Constants.avgStyleAltBold,
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Summary",
                              style: Constants.priceStyleAlt,
                            ),
                            Text(
                              "£${total + 0}",
                              style: Constants.avgStyleAltBold,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //BUTTON
                      InkWell(
                        onTap: () async {
                          await payment(user, true);
                        },
                        child: Center(
                          child: SizedBox(
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
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
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
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ));
  }

  Future<void> guestPayment(method, finalTotal) async {
    showLoader(context);
    showToast("Placing order", Constants.primaryColor);
    MyUser create = await UserRepositoryImpl.createGuestAccount(user: user);
    if (create.id != "0") {
      bool ordered = await ProductRepositoryImpl.createOrder(
          id: create.id!,
          total: finalTotal,
          payment: method,
          items: widget.cartItems);
      if (ordered) {
        await BlocProvider.of<CartCubit>(context).emptyCart();
        pop(context);
        showToast("Success", Colors.green);
      } else {
        showToast("Could not place order", Colors.red);
      }
    }
    pop(context);
  }

  Future<void> userPayment(usr, method, finalTotal) async {
    showLoader(context);
    showToast("Placing order", Constants.primaryColor);
    bool ordered = await ProductRepositoryImpl.createOrder(
        id: usr.id!,
        total: finalTotal,
        payment: "cash",
        items: widget.cartItems);
    if (ordered) {
      await BlocProvider.of<CartCubit>(context).emptyCart();
      pop(context);
      showToast("Success", Colors.green);
    } else {
      showToast("Could not place order", Colors.red);
    }
    pop(context);
  }

  Widget getBlocWidget() {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
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
                          log: true,
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
                  onTap: () async {
                    int g = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PaymentSelectScreen(
                                  group: group,
                                )));
                    setState(() {
                      group = g;
                    });
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
                                  group == 0
                                      ? FontAwesomeIcons.cashRegister
                                      : (group == 1
                                          ? FontAwesomeIcons.creditCard
                                          : FontAwesomeIcons.paypal),
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                  group == 0
                                      ? "Cash on Delivery"
                                      : (group == 1
                                          ? "Credit/Debit Card"
                                          : "Paypal"),
                                  style: const TextStyle(
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
                      const SizedBox(),
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
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.orangeAccent,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
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
                            "£0.0",
                            style: Constants.priceStyleAlt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //PROMO
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
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
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextField(
                            controller: promoCont,
                            decoration: InputDecoration(
                                hintText: "Xedwfwe4W4S",
                                hintStyle: const TextStyle(color: Colors.grey),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (promo) {
                            showToast("Promo already applied",
                                Constants.primaryColor);
                          } else {
                            showToast("Applying promo", Constants.primaryColor);
                            int p = await ProductRepositoryImpl.getPromo(
                                promo: promoCont.text);
                            if (p == 0) {
                              showToast("Promo code not valid",
                                  Constants.primaryColor);
                            } else {
                              setState(() {
                                total =
                                    (widget.total - (widget.total * (p / 100)))
                                        .toInt();
                                discount = (widget.total * (p / 100)).toInt();
                                promo = true;
                                // debugPrint((total - (total * (p / 100)))
                                //     .toInt()
                                //     .toString());
                              });
                              showToast(
                                  "Promo applied", Constants.primaryColor);
                            }
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              'apply',
                              style: Constants.avgStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //SUMMARY
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order",
                        style: Constants.priceStyleAlt,
                      ),
                      Text(
                        "£${widget.total}",
                        style: Constants.avgStyleAltBold,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Delivery",
                //         style: Constants.priceStyleAlt,
                //       ),
                //       Text(
                //         "£0",
                //         style: Constants.avgStyleAltBold,
                //       ),
                //     ],
                //   ),
                // ),
                if (promo)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Promo discount",
                          style: Constants.priceStyleAlt,
                        ),
                        Text(
                          "- £$discount",
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
                        "Summary",
                        style: Constants.priceStyleAlt,
                      ),
                      Text(
                        "£${total + 0}",
                        style: Constants.avgStyleAltBold,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //BUTTON
                InkWell(
                  onTap: () async {
                    await payment(state.user, false);
                  },
                  child: Center(
                    child: SizedBox(
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
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
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      } else {
        return buildLoading();
      }
    });
  }

  Future<void> payment(MyUser usr, bool guest) async {
    if (usr.email == null ||
        usr.address == null ||
        usr.city == null ||
        usr.country == null ||
        usr.phone == null) {
      showToast("Please add address details", Colors.red);
    } else {
      var finalTotal = total + discount + 0;
      if (group == 2 || group == 1) {
        bool done = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentScreen(
                    price: finalTotal.toString(),
                    email: usr.email!,
                    type: group.toString(),
                  ),
                )) ??
            false;
        if (done) {
          if (guest) {
            await guestPayment(group == 1 ? "stripe" : "paypal", finalTotal);
          } else {
            await userPayment(
                usr, group == 1 ? "stripe" : "paypal", finalTotal);
          }
        } else {
          showToast("Payment was not completed", Colors.red);
        }
      } else {
        if (guest) {
          await guestPayment("cash", finalTotal);
        } else {
          await userPayment(usr, "cash", finalTotal);
        }
      }
    }
  }
}
