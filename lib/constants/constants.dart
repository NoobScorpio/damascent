import 'package:damascent/screens/login_screen.dart';
import 'package:damascent/screens/notifications.dart';
import 'package:damascent/screens/profile_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const baseURL = "https://damascent.com/api/package";
const imageURL = "https://www.damascent.com";
Widget getHeader({context, required bool back, required text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      if (back)
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const BackButton(),
        ),
      if (!back)
        InkWell(
          onTap: () {
            push(context, const Notifications());
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                // size: 25,
              ),
            ),
          ),
        ),
      if (text != "Home")
        Expanded(
            child: Center(
                child: Text(
          text,
          style: Constants.bigStyleAlt,
        ))),
      if (text == "Home")
        Expanded(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset("assets/black_logo.png"),
          ),
        )),
      BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return InkWell(
              onTap: () {
                push(
                    context,
                    ProfileScreen(
                      user: state.user,
                    ));
              },
              child: const Padding(
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
            );
          } else {
            return InkWell(
              onTap: () {
                push(context, const LoginScreen());
              },
              child: const Padding(
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
            );
          }
        },
      ),
    ],
  );
}

Widget getTextFieldProfile(cont, text) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none)),
  );
}

Widget getPasswordField(cont, text, obs) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: TextField(
      controller: cont,
      style: const TextStyle(color: Colors.grey),
      cursorColor: Colors.white,
      obscureText: obs,
      decoration: InputDecoration(
        hintText: text.toString(),
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: InkWell(
          onTap: () {
            obs = !obs;
          },
          child: Icon(
            obs ? Icons.hide_source : Icons.remove_red_eye_outlined,
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
  );
}

Widget getTextField(controller, text, icon, input, validator, length) {
  return length
      ? TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.grey),
          cursorColor: Colors.white,
          maxLength: 12,
          obscureText: text == 'Password' ? true : false,
          keyboardType: input,
          validator: validator,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
          ),
        )
      : TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.grey),
          cursorColor: Colors.white,
          obscureText: text == 'Password' ? true : false,
          keyboardType: input,
          validator: validator,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
          ),
        );
}

Widget buildLoading() {
  return const Padding(
    padding: EdgeInsets.all(25.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget emptyCart() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      SizedBox(
        height: 150,
      ),
      Center(
          child: Icon(
        Icons.shopping_cart_outlined,
        size: 60,
      )
          // SvgPicture.asset("assets/images/emptyCart.svg",
          //     semanticsLabel: 'Cart Logo')
          ),
      SizedBox(
        height: 15,
      ),
      Center(
        child: Text(
          'Your cart is empty \nAdd items in cart to display',
          style: TextStyle(
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}

class Constants {
  static String appName = "Damascent";
  static TextStyle bigStyle = const TextStyle(
      color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle bigStyleAlt = const TextStyle(
      color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle smallStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle smallStyleAlt = const TextStyle(
      color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle avgStyleAlt = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle avgStyleAltBold = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle avgStyleBold = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle avgStyle = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle priceStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Raleway');
  static TextStyle priceStyleAlt = const TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Raleway');
  static Color primaryColor = const Color(0xffFF9900);
}

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

push(context, obj) {
  Navigator.push(context, MaterialPageRoute(builder: (c) => obj));
}

pop(context) {
  Navigator.pop(context);
}
