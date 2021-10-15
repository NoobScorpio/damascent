import 'package:card_swiper/card_swiper.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/profile_screen.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.animateTo(100,
          duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
    });
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
                  InkWell(
                    onTap: () {
                      push(context, ProfileScreen());
                    },
                    child: Padding(
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
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Home",
                    style: Constants.avgStyleAltBold,
                  ))),
                  Row(
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                            // size: 25,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            // size: 25,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover Scents",
                    style: Constants.avgStyleAltBold,
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: getWidth(context),
                height: getHeight(context) * 0.39,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ProductWidgetMain();
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot Deals",
                    style: Constants.avgStyleAltBold,
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
              ListView.builder(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ProductWidgetCard(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
