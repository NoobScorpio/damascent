import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/notifications.dart';
import 'package:damascent/screens/profile_screen.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     if (mounted) {
    //       _controller.animateTo(100,
    //           duration: const Duration(seconds: 2),
    //           curve: Curves.fastOutSlowIn);
    //     }
    //   });
    // });
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
              getHeader(context: context, back: false, text: "Home"),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Search Products",
                style: Constants.avgStyleAltBold,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Search our products",
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover Scents",
                    style: Constants.avgStyleAltBold,
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.maxFinite,
                // height: 400,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    // print('INSIDE BRAND');
                    if (state is ProductInitialState) {
                      return SizedBox(
                          height: getHeight(context) * 0.39,
                          child: buildLoading());
                    } else if (state is ProductLoadingState) {
                      return SizedBox(
                          height: getHeight(context) * 0.39,
                          child: buildLoading());
                    } else if (state is ProductLoadedState) {
                      if (state.products == []) {
                        return SizedBox(
                            height: getHeight(context) * 0.39,
                            child: buildLoading());
                      } else {
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            _controller.animateTo(100,
                                duration: const Duration(seconds: 3),
                                curve: Curves.fastOutSlowIn);
                          }
                        });
                        return SizedBox(
                          width: getWidth(context),
                          height: getHeight(context) * 0.39,
                          child: ListView.builder(
                            controller: _controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return ProductWidgetMain(
                                product: state.products[index],
                                name: state.products[index].pname,
                                desc: state.products[index].description,
                                image: state.products[index].image1,
                                price: state.products[index].price,
                              );
                            },
                          ),
                        );
                      }
                    } else if (state is ProductErrorState) {
                      return SizedBox(
                          height: getHeight(context) * 0.39,
                          child: buildErrorUi(state.message));
                    } else {
                      return SizedBox(
                        height: getHeight(context) * 0.39,
                        child:
                            buildErrorUi('No products available at the moment'),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Deals",
                    style: Constants.avgStyleAltBold,
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                // height: 400,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    // print('INSIDE BRAND');
                    if (state is ProductInitialState) {
                      return buildLoading();
                    } else if (state is ProductLoadingState) {
                      return buildLoading();
                    } else if (state is ProductLoadedState) {
                      if (state.products == []) {
                        return buildLoading();
                      } else {
                        return SizedBox(
                          child: ListView.builder(
                            itemCount: state.products.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: state.products[index].keyword == "hot"
                                    ? ProductWidgetCard(
                                        product: state.products[index],
                                        name: state.products[index].pname,
                                        discount:
                                            state.products[index].discount,
                                        price: state.products[index].price,
                                        image: state.products[index].image1,
                                      )
                                    : const SizedBox(),
                              );
                            },
                          ),
                        );
                      }
                    } else if (state is ProductErrorState) {
                      return buildErrorUi(state.message);
                    } else {
                      return buildErrorUi(
                          'No products available at the moment');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await http.get(Uri.parse(baseURL + "/promo.php"));
          var promos = json.decode(response.body)['records'];
          for (var promo in promos) {
            print(promo);
          }
        },
      ),
    );
  }
}
