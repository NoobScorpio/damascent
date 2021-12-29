import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/login_screen.dart';
import 'package:damascent/screens/product_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:damascent/state_management/wishlist/wishlist_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDiscoverProductWidget extends StatelessWidget {
  const HomeDiscoverProductWidget(
      {Key? key, required this.product, required this.id})
      : super(key: key);
  final String id;
  final Product product;
  @override
  Widget build(BuildContext context) {
    debugPrint("$imageURL/${product.image1}");
    return InkWell(
      onTap: () {
        push(context, ProductScreen(product: product, id: id));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: getHeight(context) * 0.26,
                  width: 205,
                  decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                        image: NetworkImage(
                          "$imageURL/${product.image3}",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.pname,
                      // "Eight & Bob",
                      style: Constants.avgStyleAltBold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        product.description,
                        // "EIGHT & BOB is a Aromatic fragrance for elegence",
                        style: Constants.smallStyleAlt,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "£${product.price}",
                          style: Constants.priceStyleAlt,
                        ),
                        BlocBuilder<UserCubit, UserState>(
                            builder: (context, ustate) {
                          return InkWell(
                            onTap: () async {
                              if (ustate is UserLoadedState) {
                                if (ustate.user.id == "" ||
                                    ustate.user.id == null) {
                                  showToast("Not logged in", Colors.red);
                                  push(context, const LoginScreen(other: true));
                                } else {
                                  showToast(
                                      "Adding Item", Constants.primaryColor);
                                  await BlocProvider.of<WishlistCubit>(context)
                                      .addWishlistProduct(
                                          pid: product.pId,
                                          id: ustate.user.id!);
                                }
                              } else {
                                showToast("Not logged in", Colors.red);
                                push(context, const LoginScreen(other: true));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/Fav.png",
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductWidgetCard extends StatelessWidget {
  const ProductWidgetCard({Key? key, required this.product, required this.id})
      : super(key: key);
  final String id;
  final Product product;
  @override
  Widget build(BuildContext context) {
    int totalDiscount = int.parse(product.price) -
        (int.parse(product.discount) * int.parse(product.price)) ~/ 100;
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
              id: id,
            ));
      },
      child: SizedBox(
        height: 110,
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
                      "$imageURL/${product.image1}",
                      // "https://www.pngplay.com/wp-content/uploads/2/Perfume-Transparent-Image.png",
                      // scale: 1.5,
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
                        product.pname,
                        // "Eight & Bob",
                        style: Constants.avgStyleAltBold,
                      ),
                      Text(
                        product.keyword,
                        // "Eight & Bob",
                        style: Constants.smallStyleAlt,
                      ),
                      Row(
                        children: [
                          Text(
                            "£$totalDiscount",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  addToCart(product: product, context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    // width: 75,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.add_shopping_cart),
                    ),
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
  const ProductNotificationCard(
      {Key? key, required this.product, required this.id})
      : super(key: key);
  final String id;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              id: id,
              product: product,
            ));
      },
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
                          borderRadius:const BorderRadius.all(Radius.circular(8))),
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
                            "£90",
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
    );
  }
}

class ProductWidgetCart extends StatelessWidget {
  const ProductWidgetCart({
    Key? key,
    required this.product,
    required this.qty,
    required this.cartItem,
  }) : super(key: key);
  final Product product;
  final int qty;
  // TODO: CHECK IF FINAL DO PROBLEMS
  final CartItem cartItem;
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
        child: SizedBox(
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
                          image: DecorationImage(
                              image: NetworkImage(
                            "$imageURL/${product.image1}",
                            // "https://www.pngplay.com/wp-content/uploads/2/Perfume-Transparent-Image.png",
                          )),
                          color: Colors.grey.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
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
                                // "Eight & Bob",
                                style: Constants.avgStyleAltBold,
                              ),
                              Text(
                                product.keyword,
                                style: const TextStyle(
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
                                "£${product.price}",
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
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
  const ProductWishlistCard({Key? key, required this.product, required this.id})
      : super(key: key);
  final Product product;
  final String id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
            context,
            ProductScreen(
              product: product,
              id: id,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
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
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                            "$imageURL/${product.image1}",
                            // "https://www.pngplay.com/wp-content/uploads/2/Perfume-Transparent-Image.png",
                          )),
                          color: Colors.grey.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
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
                                // "Eight & Bob",
                                style: Constants.avgStyleAltBold,
                              ),
                              Text(
                                product.keyword,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "£${product.price}",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  showToast(
                                      "Removing Item", Constants.primaryColor);
                                  await BlocProvider.of<WishlistCubit>(context)
                                      .removeWishlistProduct(
                                          pid: product.pId, id: id);
                                },
                                child: Container(
                                  // width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.black,
                                    ),
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

class DiscoverProductWidget extends StatelessWidget {
  const DiscoverProductWidget(
      {Key? key, required this.product, required this.id})
      : super(key: key);
  final String id;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, ProductScreen(product: product, id: id));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          child: Column(
            children: [
              Container(
                // width: 100,
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "$imageURL/${product.image1}",
                          // "https://www.pngplay.com/wp-content/uploads/2/Perfume-Transparent-Image.png",
                        )),
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        product.pname,
                        // "Eight & Bob",
                        style: Constants.avgStyleAltBold,
                      ),
                    ),

                    Text(
                      "Hot",
                      style: Constants.smallStyleAlt,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "£${product.price}",
                          style: Constants.priceStyleAlt,
                        ),
                        InkWell(
                          onTap: () {
                            // addToCart(product: product, context: context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  color: Colors.grey[200]),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
