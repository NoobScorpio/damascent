import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/product.dart';
import 'package:damascent/screens/search_screen.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();
  final TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
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
              getHeader(context: context, back: false, text: "Home"),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Search Products",
                style: Constants.avgStyleAltBold,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                if (state is ProductLoadedState) {
                  return SearchProducts(
                      id: widget.id,
                      loaded: true,
                      products: state.products,
                      search: search);
                } else {
                  return SearchProducts(
                      id: widget.id,
                      loaded: false,
                      products: const [],
                      search: search);
                }
              }),
              // DISCOVER
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
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (mounted) {
                            _controller.animateTo(100,
                                duration: const Duration(seconds: 3),
                                curve: Curves.fastOutSlowIn);
                          }
                        });
                        return Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                // List<Widget> widgets = [];
                                // for (Product prod in state.products) {
                                //   widgets.add(DiscoverProductWidget(
                                //       product: prod, id: widget.id));
                                // }
                                //
                                // push(
                                //     context,
                                //     DiscoverScreen(
                                //         products: state.products,
                                //         id: widget.id,
                                //         title: "Discover"));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discover Scents",
                                    style: Constants.avgStyleAltBold,
                                  ),
                                  // const Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: getWidth(context),
                              height: getHeight(context) * 0.41,
                              child: ListView.builder(
                                controller: _controller,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  return HomeDiscoverProductWidget(
                                      product: state.products[index],
                                      id: widget.id);
                                },
                              ),
                            ),
                          ],
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
              // HOT Deals
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
                        List<Widget> widgets = [];
                        List<String> added = [];
                        for (int i = 0; i < state.products.length; i++) {
                          if (!added.contains(state.products[i].keyword)) {
                            widgets.add(
                              ProductWidgetCard(
                                  product: state.products[i], id: widget.id),
                            );
                            added.add(state.products[i].keyword);
                          }
                        }

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // push(
                                //     context,
                                //     DiscoverScreen(
                                //         products: state.products,
                                //         id: widget.id,
                                //         title: "Hot"));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Families",
                                    style: Constants.avgStyleAltBold,
                                  ),
                                  // const Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: widgets,
                            ),
                          ],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     var response = await http.get(Uri.parse(baseURL + "/promo.php"));
      //     var promos = json.decode(response.body)['records'];
      //     for (var promo in promos) {
      //       print(promo);
      //     }
      //   },
      // ),
    );
  }
}

class SearchProducts extends StatelessWidget {
  const SearchProducts({
    Key? key,
    required this.id,
    required this.products,
    required this.loaded,
    required this.search,
  }) : super(key: key);
  final String id;
  final List<Product> products;
  final bool loaded;
  final TextEditingController search;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: search,
        decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                if (loaded) {
                  push(
                      context,
                      SearchScreen(
                          products: products, id: id, search: search.text));
                } else {
                  showToast("Products not loaded", Colors.red);
                }
              },
              child: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            hintText: "Search our products",
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
