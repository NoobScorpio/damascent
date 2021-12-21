import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen(
      {Key? key, required this.products, required this.id, required this.title})
      : super(key: key);
  final List<Product> products;
  final String id, title;
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  Map<String, bool> selected = {};
  String category = categories[0];
  @override
  void initState() {
    super.initState();
    for (var str in categories) {
      selected[str] = false;
    }
    selected[categories[0]] = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const BackButton(),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    widget.title == "Hot" ? "Families" : widget.title,
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
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          for (var str in categories) {
                            setState(() {
                              selected[str] = false;
                            });
                          }
                          setState(() {
                            selected[categories[index]] = true;
                            category = categories[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selected[categories[index]]!
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  categories[index],
                                  style: selected[categories[index]]!
                                      ? Constants.avgStyle
                                      : Constants.avgStyleAlt,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              getProductsGrid(category),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProductsGrid(category) {
    List<Widget> widgets = [];
    for (Product prod in widget.products) {
      debugPrint(prod.keyword.toLowerCase());
      if (prod.keyword
          .toLowerCase()
          .contains(category.toString().toLowerCase())) {
        widgets.add(DiscoverProductWidget(product: prod, id: widget.id));
      }
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 25,
      childAspectRatio: 0.9,
      children: widgets,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
