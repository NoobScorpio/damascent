import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Product product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
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
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: BackButton(),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  product.pname,
                  style: Constants.avgStyleAltBold,
                ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/Fav.png",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/base.png",
                      scale: 0.9,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.network(
                      "$imageURL/${product.image1}",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Eau De Parfum',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        product.pname,
                        style: Constants.avgStyleAltBold,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // RatingBar(
                      //   initialRating: 5.0,
                      //   minRating: 0,
                      //   maxRating: 5.0,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   ignoreGestures: true,
                      //   itemSize: 15,
                      //   ratingWidget: RatingWidget(
                      //       half: Icon(
                      //         Icons.star_half,
                      //         color: Colors.amber,
                      //         size: 5,
                      //       ),
                      //       full: Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //         size: 5,
                      //       ),
                      //       empty: Icon(
                      //         Icons.star_border_outlined,
                      //         color: Colors.amber,
                      //         size: 5,
                      //       )),
                      //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      //   onRatingUpdate: (val) {},
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Text(
                        "\$${product.price}",
                        style: Constants.priceStyleAlt,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Description",
                        style: Constants.avgStyleAltBold,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        product.description,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            addToCart(product: product, context: context);
                          },
                          child: SizedBox(
                            width: 215,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add to cart",
                                        style: Constants.avgStyleBold,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.add_shopping_cart),
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
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
