import 'dart:convert';

import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/data_management/repos/user_repo.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation(
      {Key? key, required this.user, required this.checkOut, required this.log})
      : super(key: key);
  final MyUser user;
  final bool checkOut;
  final bool log;
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late MyUser user;
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
  void initState() {
    super.initState();
    if (widget.log) {
      user = widget.user;
      fName.text = user.fName!;
      lName.text = user.lName!;
      email.text = user.email!;
      phone.text = user.phone!;
      address.text = user.address!;
      address2.text = user.address1!;
      city.text = user.city!;
      country.text = user.country!;
      state.text = user.state!;
      zip.text = user.zip!;
    } else {
      if (widget.user.fName != null) {
        user = widget.user;
        fName.text = user.fName!;
        lName.text = user.lName!;
        email.text = user.email!;
        phone.text = user.phone!;
        address.text = user.address!;
        address2.text = user.address1!;
        city.text = user.city!;
        country.text = user.country!;
        state.text = user.state!;
        zip.text = user.zip!;
      }
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.log) {
          pop(context);
          return true;
        } else {
          Navigator.pop(context, MyUser(id: "0"));
          return true;
        }
      },
      child: Scaffold(
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
                      "Personal Information",
                      style: Constants.bigStyleAlt,
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

                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Shipping address",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //HEADER
                      getTextFieldProfile(
                        email,
                        "Email",
                        TextInputType.emailAddress,
                        (val) {
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
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      getTextFieldProfile(
                        phone,
                        "Phone",
                        TextInputType.number,
                        (val) {
                          Pattern pattern = r'^[0-9]';
                          RegExp regex = RegExp(pattern.toString());
                          if (val == "") {
                            return 'Enter phone number';
                          }
                          if (regex.hasMatch(
                                  val.trim().toString().toLowerCase()) &&
                              val.toString().length <= 12 &&
                              val.toString().length >= 10) {
                            return null;
                          } else {
                            return 'Enter a valid phone number';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: getTextFieldProfile(
                                fName, "First Name", TextInputType.name, (val) {
                              Pattern pattern = r'^[a-zA-Z]+$';
                              RegExp regex = RegExp(pattern.toString());
                              if (regex.hasMatch(
                                  val.trim().toString().toLowerCase())) {
                                return null;
                              } else {
                                return 'Enter valid first name';
                              }
                            }),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: getTextFieldProfile(
                                lName, "Last Name", TextInputType.name, (val) {
                              Pattern pattern = r'^[a-zA-Z]+$';
                              RegExp regex = RegExp(pattern.toString());
                              if (regex.hasMatch(
                                  val.trim().toString().toLowerCase())) {
                                return null;
                              } else {
                                return 'Enter valid last name';
                              }
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //ADDRESS
                      getTextFieldProfile(
                        address,
                        "Address",
                        TextInputType.name,
                        (val) {
                          if (val.toString().isEmpty) {
                            return "Please enter address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      getTextFieldProfile(
                        address2,
                        "Address2",
                        TextInputType.name,
                        (val) {
                          // if (val.toString().isEmpty) {
                          //   return "Please enter address 2";
                          // } else {
                          //   return null;
                          // }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //LOCATION
                      Row(
                        children: [
                          Expanded(
                            child: getTextFieldProfile(
                              city,
                              "City",
                              TextInputType.name,
                              (val) {
                                Pattern pattern = r'^[a-zA-Z]+$';
                                RegExp regex = RegExp(pattern.toString());
                                if (regex.hasMatch(
                                    val.trim().toString().toLowerCase())) {
                                  return null;
                                } else {
                                  return 'Enter valid city';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: getTextFieldProfile(
                              state,
                              "State",
                              TextInputType.name,
                              (val) {
                                Pattern pattern = r'^[a-zA-Z]+$';
                                RegExp regex = RegExp(pattern.toString());
                                if (regex.hasMatch(
                                    val.trim().toString().toLowerCase())) {
                                  return null;
                                } else {
                                  return 'Enter valid state';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: getTextFieldProfile(
                              country,
                              "Country",
                              TextInputType.name,
                              (val) {
                                Pattern pattern = r'^[a-zA-Z]+$';
                                RegExp regex = RegExp(pattern.toString());
                                if (regex.hasMatch(
                                    val.trim().toString().toLowerCase())) {
                                  return null;
                                } else {
                                  return 'Enter valid country';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: getTextFieldProfile(
                              zip,
                              "Postal Code",
                              TextInputType.name,
                              (val) {
                                if (val.toString().isEmpty) {
                                  return "Enter Zip Code";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //FIRST LAST NAME

                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      showToast("Saving Data", Constants.primaryColor);

                      if (formKey.currentState!.validate()) {
                        // showToast("Validated", Constants.primaryColor);
                        if (widget.log) {
                          bool updated =
                              await BlocProvider.of<UserCubit>(context)
                                  .updateProfile(
                                      user: MyUser(
                                          fName: fName.text.toString(),
                                          lName: lName.text.toString(),
                                          email: email.text.toString(),
                                          state: state.text.toString(),
                                          password: user.password,
                                          country: country.text.toString(),
                                          city: city.text.toString(),
                                          phone: phone.text.toString(),
                                          zip: zip.text.toString(),
                                          address: address.text.toString(),
                                          address1: address2.text.toString(),
                                          id: user.id));
                          if (updated) {
                            showToast("Success", Constants.primaryColor);

                            pop(context);
                            if (!widget.checkOut) {
                              pop(context);
                            }
                          }
                        } else {
                          showLoader(context);
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          MyUser guest = MyUser(
                              fName: fName.text.toString(),
                              lName: lName.text.toString(),
                              email: email.text.toString(),
                              state: state.text.toString(),
                              password: "",
                              country: country.text.toString(),
                              city: city.text.toString(),
                              phone: phone.text.toString(),
                              zip: zip.text.toString(),
                              address: address.text.toString(),
                              address1: address2.text.toString(),
                              id: "");
                          MyUser u =
                              await UserRepositoryImpl.createGuestAccount(
                                  user: guest);
                          await sp.setString("guest", json.encode(u.toJson()));
                          Navigator.pop(context);
                          Navigator.pop(context, u);
                          showToast("Saved", Constants.primaryColor);
                        }
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Save",
                            style: Constants.avgStyleBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
