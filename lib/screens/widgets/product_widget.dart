import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductWidgetMain extends StatelessWidget {
  const ProductWidgetMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, ProductScreen());
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 15),
            child: Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DAMASCENT",
                        style: Constants.avgStyleAlt,
                      ),
                      SizedBox(
                        height: 5,
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
                        height: 25,
                      ),
                      Text(
                        "Kayla Franci",
                        style: Constants.avgStyleAlt,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$169",
                        style: Constants.priceStyleAlt,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -5,
            left: 10,
            child: Image.asset(
              "assets/product.png",
              scale: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductWidgetCard extends StatelessWidget {
  const ProductWidgetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, ProductScreen());
      },
      child: Container(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      "assets/product.png",
                      // scale: 2.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DAMASCENT",
                        style: Constants.avgStyleAlt,
                      ),
                      Row(
                        children: [
                          Text(
                            "\$90",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "\$169",
                            style: Constants.priceStyleAlt,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  // width: 75,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
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
    );
  }
}

class ProductWidgetCart extends StatelessWidget {
  const ProductWidgetCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, ProductScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 140,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          "assets/product.png",
                          // scale: 2.5,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dolce & Gabbana",
                                style: Constants.avgStyleAltBold,
                              ),
                              Text(
                                "Solid Mate",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$90",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        // width: 75,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        // width: 75,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
