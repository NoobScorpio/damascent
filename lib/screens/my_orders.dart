import 'package:damascent/constants/constants.dart';
import 'package:damascent/state_management/order/order_cubit.dart';
import 'package:damascent/state_management/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key, required this.id}) : super(key: key);

  final String id;
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool delivered = false;
  bool processing = true;
  bool shipped = false;
  String status = "processing";
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).getOrders(id: widget.id);
  }

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
                          delivered = false;
                          shipped = false;
                          processing = true;
                          status = "processing";
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
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          delivered = false;
                          shipped = true;
                          processing = false;
                          status = "shipped";
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color:
                                  shipped ? Colors.black : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: Text(
                              "Shipped",
                              style: shipped
                                  ? Constants.avgStyle
                                  : Constants.avgStyleAlt,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          delivered = true;
                          shipped = false;
                          processing = false;
                          status = "delivered";
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
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
                if (state is OrderLoadedState) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return status == state.orders[index].status
                            ? OrderWidget(
                                oid: state.orders[index].oid,
                                status: state.orders[index].status,
                                date: state.orders[index].date,
                                total: state.orders[index].total)
                            : Container();
                      });
                } else {
                  return buildLoading();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.oid,
    required this.status,
    required this.date,
    required this.total,
  }) : super(key: key);
  final String oid, status, date, total;
  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order No:",
                        style: Constants.priceStyleAlt,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        oid,
                        style: Constants.avgStyleAltBold,
                      ),
                    ],
                  ),
                  Text(
                    date,
                    style: Constants.priceStyleAlt,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                    "£$total",
                    style: Constants.avgStyleAltBold,
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
                  Text(
                    status,
                    style: const TextStyle(
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
  }
}
