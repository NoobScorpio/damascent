import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool delivered = true;
  bool processing = false;
  bool cancelled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
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
                    "My orders",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          delivered = true;
                          cancelled = false;
                          processing = false;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: delivered
                                  ? Colors.black
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Text(
                              "Delivered",
                              style: delivered
                                  ? Constants.avgStyle
                                  : Constants.avgStyleAlt,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          delivered = false;
                          cancelled = false;
                          processing = true;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: processing
                                  ? Colors.black
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Text(
                              "Processing",
                              style: processing
                                  ? Constants.avgStyle
                                  : Constants.avgStyleAlt,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          delivered = false;
                          cancelled = true;
                          processing = false;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: cancelled
                                  ? Colors.black
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Text(
                              "Cancelled",
                              style: cancelled
                                  ? Constants.avgStyle
                                  : Constants.avgStyleAlt,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //ORDER NO
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Order No:",
                                        style: Constants.priceStyleAlt,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "gff23fgfasffasf",
                                        style: Constants.avgStyleAltBold,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "09-09-2021",
                                    style: Constants.priceStyleAlt,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //TRACK NO
                              Row(
                                children: [
                                  Text(
                                    "Tracking No:",
                                    style: Constants.priceStyleAlt,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "gff23fgfasffasf",
                                    style: Constants.avgStyleAltBold,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //QUANTITY
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity:",
                                        style: Constants.priceStyleAlt,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "3",
                                        style: Constants.avgStyleAltBold,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Amount:",
                                        style: Constants.priceStyleAlt,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "\$125",
                                        style: Constants.avgStyleAltBold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //STATUS
                              Row(
                                children: [
                                  Text(
                                    "Status:",
                                    style: Constants.priceStyleAlt,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    "Delivered",
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
