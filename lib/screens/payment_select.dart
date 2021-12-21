import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentSelectScreen extends StatefulWidget {
  const PaymentSelectScreen({Key? key, required this.group}) : super(key: key);

  final int group;
  @override
  _PaymentSelectScreenState createState() => _PaymentSelectScreenState();
}

class _PaymentSelectScreenState extends State<PaymentSelectScreen> {
  late int group;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                    Expanded(
                        child: Center(
                            child: Text(
                      "Payment method",
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

                //COD
                // InkWell(
                //   onTap: () {
                //     Navigator.pop(context, 0);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 8),
                //     child: Card(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15.0),
                //       ),
                //       elevation: 0,
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             vertical: 25, horizontal: 25),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const Icon(
                //                   FontAwesomeIcons.cashRegister,
                //                   color: Colors.orange,
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 15.0),
                //                   child: Text(
                //                     "Cash on Delivery",
                //                     style: Constants.avgStyleAltBold,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Radio(
                //               activeColor: Constants.primaryColor,
                //               value: 0,
                //               groupValue: group,
                //               onChanged: (val) {
                //                 setState(() => group = val as int);
                //                 Navigator.pop(context, 0);
                //               },
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 12,
                ),
                //VISA
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.stripe,
                                  color: Colors.redAccent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "Stripe",
                                    style: Constants.avgStyleAltBold,
                                  ),
                                ),
                              ],
                            ),
                            Radio(
                              activeColor: Constants.primaryColor,
                              value: 1,
                              groupValue: group,
                              onChanged: (val) {
                                setState(() => group = val as int);
                                Navigator.pop(context, 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                //BITCOIN
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 2);
                  },
                  child: Padding(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.paypal,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "Paypal",
                                    style: Constants.avgStyleAltBold,
                                  ),
                                ),
                              ],
                            ),
                            Radio(
                              activeColor: Constants.primaryColor,
                              value: 2,
                              groupValue: group,
                              onChanged: (val) {
                                setState(() => group = val as int);
                                Navigator.pop(context, 2);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
