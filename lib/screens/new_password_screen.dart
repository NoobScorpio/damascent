import 'dart:convert';
import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController pass2 = TextEditingController(),
      pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.colorBurn,
              child: Image.asset("assets/login_bg.png"),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "assets/forget.svg",
                      semanticsLabel: 'Acme Logo',
                      height: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "New Password",
                    style: Constants.bigStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Enter your verification code below and enter your new password",
                      style: Constants.smallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: getTextField(
                                pass,
                                'New Password',
                                Icons.lock_outline,
                                TextInputType.visiblePassword, (val) {
                              if (val.toString().length <= 5) {
                                return 'Password should be atleast 6 characters';
                              } else {
                                return null;
                              }
                            }, false),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: getTextField(
                                pass2,
                                'Confirm Password',
                                Icons.lock_outline,
                                TextInputType.visiblePassword, (val) {
                              if (val == pass.text) {
                                return null;
                              } else {
                                return 'Passwords do not match';
                              }
                            }, false),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          showToast("Logging in", Constants.primaryColor);
                          if (pass2.text != "" && pass.text != "") {
                            bool loggedIn =
                                await BlocProvider.of<UserCubit>(context)
                                    .loginUser(pass2.text, pass.text);
                            if (loggedIn) {
                              showToast("Success", Colors.green);
                              await BlocProvider.of<CartCubit>(context)
                                  .initializeCart();
                              await BlocProvider.of<ProductCubit>(context)
                                  .getProducts();
                              var sp = await SharedPreferences.getInstance();
                              MyUser newUser = MyUser.fromJson(
                                  json.decode(sp.getString('user')!));
                              push(
                                  context,
                                  NavigationScreen(
                                    id: newUser.id!,
                                  ));
                            }
                          } else {
                            showToast("Please fill all fields", Colors.red);
                          }
                        }
                      },
                      child: const Text('Confirm',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 150)),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
