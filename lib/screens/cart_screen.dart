import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/checkout_screen.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: AssetImage("assets/login_bg.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Cart",
                    style: Constants.avgStyleAltBold,
                  ))),
                  Row(
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                            // size: 25,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            // size: 25,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ListView.builder(
                itemCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ProductWidgetCart(),
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  // height: 140,
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
                              SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dolce & Gabbana",
                                      style: Constants.priceStyleAlt,
                                    ),
                                    Text(
                                      "\$120",
                                      style: Constants.priceStyleAlt,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dolce & Gabbana",
                                      style: Constants.priceStyleAlt,
                                    ),
                                    Text(
                                      "\$120",
                                      style: Constants.priceStyleAlt,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dolce & Gabbana",
                                      style: Constants.priceStyleAlt,
                                    ),
                                    Text(
                                      "\$120",
                                      style: Constants.priceStyleAlt,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
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
                                    "(3 items)",
                                    style: Constants.priceStyleAlt,
                                  ),
                                ],
                              ),
                              Text(
                                "\$360",
                                style: Constants.avgStyleAltBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  push(context, CheckoutScreen());
                },
                child: Center(
                  child: Container(
                    // width: 215,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.delivery_dining),
                                      ),
                                    ),
                                    SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                width: 1,
                                height: 35,
                                color: Colors.white,
                              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
