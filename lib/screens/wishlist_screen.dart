import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:damascent/state_management/wishlist/wishlist_cubit.dart';
import 'package:damascent/state_management/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("LOADING WISHLIST ${widget.id}");
    if (widget.id != "") {
      BlocProvider.of<WishlistCubit>(context)
          .getWishlistProducts(id: widget.id);
    }
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
              getHeader(context: context, back: false, text: "WishList"),
              BlocBuilder<UserCubit, UserState>(builder: (context, ustate) {
                if (ustate is UserLoadedState) {
                  if (ustate.user.id == "" || ustate.user.id == null) {
                    return const Center(
                      child: Text("Log in to see your wishlist"),
                    );
                  }
                  BlocProvider.of<WishlistCubit>(context)
                      .getWishlistProducts(id: widget.id);
                  return BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, state) {
                    if (state is WishlistLoadedState) {
                      if (state.products.isEmpty) {
                        return const Center(
                          child: Text("No item in wishlist"),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.products.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ProductWishlistCard(
                                product: state.products[index],
                                id: widget.id,
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      if (widget.id == "") {
                        return const Center(
                          child: Text("Log in to see your wishlist"),
                        );
                      } else {
                        return buildLoading();
                      }
                    }
                  });
                } else {
                  return const Center(
                    child: Text("Log in to see your wishlist"),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
