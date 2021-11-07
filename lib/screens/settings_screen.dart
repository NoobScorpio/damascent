import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController oldPass = TextEditingController(),
      newPass = TextEditingController(),
      confirmPass = TextEditingController();
  bool obs1 = true, obs2 = true, obs3 = true, noti = true;
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
              getHeader(context: context, text: "", back: true),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Settings",
                style: Constants.bigStyleAlt,
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Reset Password",
                        style: Constants.avgStyleAltBold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextField(
                        controller: oldPass,
                        style: const TextStyle(color: Colors.grey),
                        cursorColor: Colors.white,
                        obscureText: obs1,
                        decoration: InputDecoration(
                          hintText: "Enter old password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obs1 = !obs1;
                              });
                            },
                            child: Icon(
                              obs1
                                  ? Icons.hide_source
                                  : Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextField(
                        controller: newPass,
                        style: const TextStyle(color: Colors.grey),
                        cursorColor: Colors.white,
                        obscureText: obs2,
                        decoration: InputDecoration(
                          hintText: "Enter new password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obs2 = !obs2;
                              });
                            },
                            child: Icon(
                              obs2
                                  ? Icons.hide_source
                                  : Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextField(
                        controller: confirmPass,
                        style: const TextStyle(color: Colors.grey),
                        cursorColor: Colors.white,
                        obscureText: obs3,
                        decoration: InputDecoration(
                          hintText: "Confirm new password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obs3 = !obs3;
                              });
                            },
                            child: Icon(
                              obs3
                                  ? Icons.hide_source
                                  : Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () async {
                                  showToast(
                                      "Saving Data", Constants.primaryColor);

                                  if (oldPass.text != "" &&
                                      newPass.text != "" &&
                                      confirmPass.text != "") {
                                    if (oldPass.text == state.user.password) {
                                      if (newPass.text == confirmPass.text) {
                                        MyUser usr = state.user;
                                        usr.password = newPass.text;
                                        bool updated =
                                            await BlocProvider.of<UserCubit>(
                                                    context)
                                                .updateProfile(user: usr);
                                        if (updated) {
                                          showToast("Success",
                                              Constants.primaryColor);
                                        } else {
                                          showToast("Could not update password",
                                              Constants.primaryColor);
                                        }
                                      } else {
                                        showToast(
                                            "New and confirm password donot match",
                                            Constants.primaryColor);
                                      }
                                    } else {
                                      showToast("Old password not correct",
                                          Constants.primaryColor);
                                    }
                                  } else {
                                    showToast("Please fill all fields",
                                        Constants.primaryColor);
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notifications',
                            style: Constants.avgStyleAlt,
                          ),
                          Switch(
                            value: noti,
                            onChanged: (val) {
                              setState(() {
                                noti = !noti;
                              });
                            },
                            inactiveTrackColor: Colors.black,
                            activeColor: Constants.primaryColor,
                          ),
                        ],
                      ),
                    )
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
