import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              SizedBox(
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
                    child: BackButton(),
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
              SizedBox(
                height: 25,
              ),
              //HEADER
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: AssetImage("assets/login_bg.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ali Adam",
                        style: Constants.avgStyleAltBold,
                      ),
                      Text(
                        "aliadam@gmail.com",
                        style: Constants.priceStyleAlt,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
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
                            "My orders", "Already have 3 orders", () {}),
                        profileOption("Shipping address", "Visa **35", () {}),
                        profileOption("Payment methods",
                            "You have special promocodes", () {}),
                        profileOption(
                            "My reviews", "Reviews for 2 items", () {}),
                        profileOption(
                            "Settings", "Notifications, Passwords", () {}),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$subTitle",
                      style: Constants.priceStyleAlt,
                    )
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
