import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/my_orders.dart';
import 'package:damascent/screens/personal_info.dart';
import 'package:damascent/screens/settings_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  final MyUser user;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MyUser user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
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
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const BackButton(),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                          "My Profile",
                          style: Constants.avgStyleAltBold,
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
                    //HEADER
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.fName ??
                                  "" " " + (state.user.lName ?? ""),
                              style: Constants.avgStyleAltBold,
                            ),
                            Text(
                              state.user.email ?? "",
                              style: Constants.priceStyleAlt,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
                          child: Column(
                            children: [
                              profileOption(
                                  "My orders", "Check your placed orders", () {
                                push(context,
                                    MyOrdersScreen(id: state.user.id ?? ""));
                              }),
                              profileOption("Personal Information",
                                  "Edit your information", () {
                                push(
                                    context,
                                    PersonalInformation(
                                      log: true,
                                      user: state.user,
                                      checkOut: false,
                                    ));
                              }),
                              // profileOption(
                              //     "Promo codes", "You have special promo codes",
                              //     () {
                              //   push(context, const DiscountScreen());
                              // }),
                              profileOption(
                                  "Settings", "Notifications, Passwords", () {
                                push(context, const SettingsScreen());
                              }),
                              profileOption("Logout", "Logout of damascent",
                                  () async {
                                await BlocProvider.of<UserCubit>(context)
                                    .logOut();
                                showToast("Logged out", Colors.green);
                                pop(context);
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => const LoginScreen(Other: true,)),
                                //     (_) => false);
                              }),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        } else {
          return buildLoading();
        }
      },
    );
  }

  Widget profileOption(title, subTitle, function) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: Constants.avgStyleAltBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$subTitle",
                      style: Constants.priceStyleAlt,
                    )
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            const Divider(
              thickness: 0.1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
