import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
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
                  "DAMASCENT",
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
            SizedBox(
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
                    child: Image.asset(
                      "assets/product.png",
                      // scale: 0.8,
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
                      Text(
                        "Ladies Scent",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dolce & Gabbana",
                        style: Constants.avgStyleAltBold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RatingBar(
                        initialRating: 5.0,
                        minRating: 0,
                        maxRating: 5.0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: 15,
                        ratingWidget: RatingWidget(
                            half: Icon(
                              Icons.star_half,
                              color: Colors.amber,
                              size: 5,
                            ),
                            full: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 5,
                            ),
                            empty: Icon(
                              Icons.star_border_outlined,
                              color: Colors.amber,
                              size: 5,
                            )),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (val) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "\$201",
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
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                          "when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\n"
                          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
                          "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, "
                          "and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Container(
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
