import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/product/product_cubit.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: getTextField(
                              fName, "First Name", Icons.person_outline),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: getTextField(lName, "Last Name",
                              Icons.person_outline_outlined),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                    child: getTextField(email, "Email", Icons.email),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child:
                          getTextField(pass, "Password", Icons.lock_outline)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child: getTextField(phone, "Phone", Icons.phone)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: getTextField(
                                city, "City", Icons.location_city_outlined)),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: getTextField(state, "State", Icons.domain)),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child: getTextField(
                          country, "Country", Icons.outlined_flag)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child: getTextField(address, "Address", Icons.home)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child: getTextField(address2, "Address2", Icons.home)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 2),
                      child:
                          getTextField(zip, "Zip Code", Icons.local_shipping)),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async {
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
                            await BlocProvider.of<CartCubit>(context)
                                .initializeCart();
                            await BlocProvider.of<ProductCubit>(context)
                                .getProducts();
                            push(context, const NavigationScreen());
                          }
                        } else {
                          showToast(
                              "Please fill all fields", Constants.primaryColor);
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
