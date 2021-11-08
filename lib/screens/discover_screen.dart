import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen(
      {Key? key, required this.products, required this.id, required this.title})
      : super(key: key);
  final List<Widget> products;
  final String id, title;
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: BackButton(),
                    ),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    widget.title,
                    style: Constants.bigStyleAlt,
                  ))),
                  Card(
                    color: Colors.grey.shade200,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey.shade200,
                        // size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              GridView.count(
                crossAxisCount: 2,
                // padding: const EdgeInsets.all(2),
                crossAxisSpacing: 10,
                mainAxisSpacing: 25,
                childAspectRatio: 0.9,
                children: widget.products,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
