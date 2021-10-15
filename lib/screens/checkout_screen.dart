import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(
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
                    child: BackButton(),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Checkout",
                    style: Constants.avgStyleAltBold,
                  ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //SHIPPING
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Shipping address",
                  style: Constants.avgStyleAltBold,
                ),
              ),
              SizedBox(
                height: 12,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Adam Ali",
                              style: Constants.avgStyleAltBold,
                            ),
                            Text(
                              "Change",
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                          style: Constants.priceStyleAlt,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //PAYMENT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment",
                      style: Constants.avgStyleAltBold,
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
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
                  ),
                ),
              ),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                height: 25,
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
      ),
    );
  }
}
