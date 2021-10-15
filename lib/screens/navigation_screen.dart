import 'package:damascent/screens/cart_screen.dart';
import 'package:damascent/screens/home_screen.dart';
import 'package:damascent/screens/search_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    CartScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/home.png"),
            activeIcon: Image.asset("assets/Selected_home.png"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/search.png"),
            activeIcon: Image.asset("assets/Selected_Search.png"),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/cart.png"),
            activeIcon: Image.asset("assets/Selected_cart.png"),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
