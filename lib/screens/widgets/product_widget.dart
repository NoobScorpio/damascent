import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/product_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductWidgetMain extends StatelessWidget {
  const ProductWidgetMain(
      {Key? key,
      required this.name,
      required this.desc,
      required this.price,
      required this.image,
      required this.product})
      : super(key: key);
  final String name, desc, price, image;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
            ));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 15),
            child: SizedBox(
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
                        name,
                        style: Constants.avgStyleAlt,
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
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

                      Text(
                        desc,
                        style: Constants.avgStyleAlt,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "\$$price",
                        style: Constants.priceStyleAlt,
                      ),
                      const SizedBox(
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
            child: SizedBox(
              height: 225,
              child: Image.network(
                "$imageURL/$image",
                // scale: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductWidgetCard extends StatelessWidget {
  const ProductWidgetCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.discount,
      required this.product})
      : super(key: key);
  final String name, image, price, discount;
  final Product product;
  @override
  Widget build(BuildContext context) {
    int totalDiscount =
        int.parse(price) - (int.parse(discount) * int.parse(price)) ~/ 100;
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
            ));
      },
      child: SizedBox(
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
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      "$imageURL/$image",
                      scale: 1.5,
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
                        name,
                        style: Constants.avgStyleAlt,
                      ),
                      Row(
                        children: [
                          Text(
                            "\$$totalDiscount",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "\$$price",
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
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
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

class ProductNotificationCard extends StatelessWidget {
  const ProductNotificationCard({Key? key, required this.product})
      : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
            ));
      },
      child: Container(
        // height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Placed",
                      style: Constants.avgStyleAltBold,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.watch_later,
                          color: Colors.black,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "12:03",
                          style: Constants.priceStyleAlt,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DAMASCENT",
                              style: Constants.avgStyleAlt,
                            ),
                            const Text(
                              "\$90",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Showdownder Drive Kenner",
                              style: Constants.priceStyleAlt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductWidgetCart extends StatelessWidget {
  ProductWidgetCart({
    Key? key,
    required this.product,
    required this.qty,
    required this.cartItem,
  }) : super(key: key);
  final Product product;
  final int qty;
  CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // push(
        //     context,
        //     ProductScreen(
        //       product: product,
        //     ));
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
                        child: Image.network(
                          "$imageURL/${product.image1}",
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
                                product.pname,
                                style: Constants.avgStyleAltBold,
                              ),
                              Text(
                                product.keyword,
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
                                "\$${product.price}",
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
                                      InkWell(
                                        onTap: () async {
                                          BlocProvider.of<CartCubit>(context)
                                              .removeItem(cartItem);
                                        },
                                        child: Container(
                                          // width: 75,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 2),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "$qty",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          BlocProvider.of<CartCubit>(context)
                                              .addItem(cartItem);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 2),
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                        ),
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

class ProductWishlistCard extends StatelessWidget {
  const ProductWishlistCard({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          // height: 140,
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
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\$169",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                // width: 75,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
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
