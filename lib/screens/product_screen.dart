import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/login_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:damascent/state_management/wishlist/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product, required this.id})
      : super(key: key);
  final Product product;
  final String id;
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
                    child: const BackButton(),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  product.pname,
                  style: Constants.avgStyleAltBold,
                ))),
                BlocBuilder<UserCubit, UserState>(builder: (context, ustate) {
                  return InkWell(
                    onTap: () async {
                      if (ustate is UserLoadedState) {
                        if (ustate.user.id == "" || ustate.user.id == null) {
                          showToast("Not logged in", Colors.red);
                          push(context, const LoginScreen(other: true));
                        } else {
                          showToast("Adding Item", Constants.primaryColor);
                          await BlocProvider.of<WishlistCubit>(context)
                              .addWishlistProduct(
                                  pid: product.pId, id: ustate.user.id!);
                        }
                      } else {
                        showToast("Not logged in", Colors.red);
                        push(context, const LoginScreen(other: true));
                      }
                    },
                    child: Padding(
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
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 500,
                        width: getWidth(context),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                "$imageURL/${product.image3}",
                              ),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.keyword,
                            style: const TextStyle(
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
                          Text(
                            "£${product.price}",
                            style: Constants.priceStyleAlt,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Description",
                            style: Constants.avgStyleAltBold,
                          ),
                          const SizedBox(
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
                                width: 180,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
