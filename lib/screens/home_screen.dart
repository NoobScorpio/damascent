import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool newArrival = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            Icons.sort,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                Positioned(
                  bottom: 10,
                  right: 3,
                  child: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 4,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: Constants.bigStyleAlt,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            newArrival = true;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New arrival",
                              style: TextStyle(
                                  color:
                                      newArrival ? Colors.black : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            if (newArrival)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5),
                                child: Container(
                                  width: 35,
                                  height: 1,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            if (!newArrival)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5),
                                child: SizedBox(),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            newArrival = false;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Best seller",
                              style: TextStyle(
                                  color:
                                      !newArrival ? Colors.black : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            if (!newArrival)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5),
                                child: Container(
                                  width: 35,
                                  height: 1,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            if (newArrival)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5),
                                child: SizedBox(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "See all",
                      style: Constants.smallStyleAlt,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              GridView.builder(
                itemCount: 10,
                padding: const EdgeInsets.all(15),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) => ProductWidget(),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
