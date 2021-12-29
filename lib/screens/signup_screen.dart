import 'dart:convert';

import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.other}) : super(key: key);
  final bool other;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fName = TextEditingController(),
      lName = TextEditingController(),
      email = TextEditingController(),
      pass = TextEditingController(),
      phone = TextEditingController(),
      city = TextEditingController(),
      state = TextEditingController(),
      country = TextEditingController(),
      address = TextEditingController(),
      address2 = TextEditingController(),
      zip = TextEditingController();

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
                    height: MediaQuery.of(context).size.height * 0.05,
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
                  Image.asset("assets/white_logo.png"),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Sign up",
                    style: Constants.bigStyle,
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              children: [
                                Expanded(
                                  child: getTextField(
                                      fName,
                                      "First Name",
                                      Icons.person_outline,
                                      TextInputType.name, (val) {
                                    Pattern pattern = r'^[a-zA-Z]+$';
                                    RegExp regex = RegExp(pattern.toString());
                                    if (regex.hasMatch(
                                        val.trim().toString().toLowerCase())) {
                                      return null;
                                    } else {
                                      return 'Enter a valid first name';
                                    }
                                  }, false),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: getTextField(
                                      lName,
                                      "Last Name",
                                      Icons.person_outline_outlined,
                                      TextInputType.name, (val) {
                                    Pattern pattern = r'^[a-zA-Z]+$';
                                    RegExp regex = RegExp(pattern.toString());
                                    if (regex.hasMatch(
                                        val.trim().toString().toLowerCase())) {
                                      return null;
                                    } else {
                                      return 'Enter a valid last name';
                                    }
                                  }, false),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            child: getTextField(email, "Email", Icons.email,
                                TextInputType.emailAddress, (val) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
                                  r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]'
                                  r'{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern.toString());
                              if (regex.hasMatch(
                                  val.trim().toString().toLowerCase())) {
                                return null;
                              } else {
                                return 'Enter a valid Email';
                              }
                            }, false),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(
                                  pass,
                                  "Password",
                                  Icons.lock_outline,
                                  TextInputType.name, (val) {
                                if (val.toString().length <= 5) {
                                  return 'Password should be atleast 6 characters';
                                } else {
                                  return null;
                                }
                              }, false)),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(phone, "Phone", Icons.phone,
                                  TextInputType.name, (val) {
                                Pattern pattern = r'^[0-9]';
                                RegExp regex = RegExp(pattern.toString());
                                if (regex.hasMatch(
                                    val.trim().toString().toLowerCase())) {
                                  return null;
                                } else {
                                  return 'Enter a valid phone number';
                                }
                              }, true)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            child: Row(
                              children: [
                                Expanded(
                                    child: getTextField(
                                        city,
                                        "City",
                                        Icons.location_city_outlined,
                                        TextInputType.name, (val) {
                                  Pattern pattern = r'^[a-zA-Z]+$';
                                  RegExp regex = RegExp(pattern.toString());
                                  if (regex.hasMatch(
                                      val.trim().toString().toLowerCase())) {
                                    return null;
                                  } else {
                                    return 'Enter a valid city name';
                                  }
                                }, false)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: getTextField(
                                        state,
                                        "State",
                                        Icons.domain,
                                        TextInputType.name, (val) {
                                  Pattern pattern = r'^[a-zA-Z]+$';
                                  RegExp regex = RegExp(pattern.toString());
                                  if (regex.hasMatch(
                                      val.trim().toString().toLowerCase())) {
                                    return null;
                                  } else {
                                    return 'Enter a valid state name';
                                  }
                                }, false)),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(
                                  country,
                                  "Country",
                                  Icons.outlined_flag,
                                  TextInputType.name, (val) {
                                Pattern pattern = r'^[a-zA-Z]+$';
                                RegExp regex = RegExp(pattern.toString());
                                if (regex.hasMatch(
                                    val.trim().toString().toLowerCase())) {
                                  return null;
                                } else {
                                  return 'Enter a valid country name';
                                }
                              }, false)),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(address, "Address",
                                  Icons.home, TextInputType.name, (val) {
                                if (val.toString().isEmpty) {
                                  return "Please enter address";
                                } else {
                                  return null;
                                }
                              }, false)),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(address2, "Address2",
                                  Icons.home, TextInputType.name, (val) {
                                // if (val.toString().isEmpty) {
                                //   return "Please enter address 2";
                                // } else {
                                //   return null;
                                // }
                              }, false)),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: getTextField(
                                  zip,
                                  "Zip Code",
                                  Icons.local_shipping,
                                  TextInputType.name, (val) {
                                if (val.toString().isEmpty) {
                                  return "Please enter Zip Code";
                                } else {
                                  return null;
                                }
                              }, false)),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          showToast("Signing Up", Constants.primaryColor);
                          if (fName.text != "" &&
                              lName.text != "" &&
                              email.text != "" &&
                              state.text != "" &&
                              pass.text != "" &&
                              country.text != "" &&
                              city.text != "" &&
                              phone.text != "" &&
                              zip.text != "" &&
                              address.text != "" &&
                              address2.text != "") {
                            // debugPrint(zip.text.toString());
                            bool created =
                                await BlocProvider.of<UserCubit>(context)
                                    .createUser(
                                        user: MyUser(
                                            fName: fName.text.toString(),
                                            lName: lName.text.toString(),
                                            email: email.text.toString(),
                                            state: state.text.toString(),
                                            password: pass.text.toString(),
                                            country: country.text.toString(),
                                            city: city.text.toString(),
                                            phone: phone.text.toString(),
                                            zip: zip.text.toString(),
                                            address: address.text.toString(),
                                            address1: address2.text.toString(),
                                            id: ""));
                            if (created) {
                              showToast("Success", Constants.primaryColor);
                              if (widget.other) {
                                pop(context);
                                pop(context);
                              } else {
                                var sp = await SharedPreferences.getInstance();
                                MyUser newUser = MyUser.fromJson(
                                    json.decode(sp.getString('user')!));
                                push(
                                    context,
                                    NavigationScreen(
                                      id: newUser.id!,
                                    ));
                              }
                            }
                          } else {
                            showToast("Please fill all fields",
                                Constants.primaryColor);
                          }
                        }
                      },
                      child: const Text('SignUp',
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
