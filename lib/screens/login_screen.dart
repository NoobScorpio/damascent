import 'dart:convert';

import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/screens/signup_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController(),
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
                  Image.asset("assets/white_logo.png"),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Login",
                    style: Constants.bigStyle,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Form(
                    key:formKey,
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: getTextField(email, 'Email', Icons.email,
                            TextInputType.emailAddress, (val) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
                              r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]'
                              r'{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern.toString());
                          if (regex
                              .hasMatch(val.trim().toString().toLowerCase())) {
                            return null;
                          } else {
                            return 'Enter a valid Email';
                          }
                        }, false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: getTextField(
                            pass,
                            'Password',
                            Icons.lock_outline,
                            TextInputType.visiblePassword,
                            (val) {},
                            false),
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot your password?",
                        style: Constants.smallStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          showToast("Logging in", Constants.primaryColor);
                          if (email.text != "" && pass.text != "") {
                            bool loggedIn =
                                await BlocProvider.of<UserCubit>(context)
                                    .loginUser(email.text, pass.text);
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
                      child: const Text('Login',
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
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const SignUpScreen());
                    },
                    child: Text(
                      "Do not have an account? Sign up here?",
                      style: Constants.smallStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
