import 'package:damascent/screens/cart_screen.dart';
import 'package:damascent/screens/home_screen.dart';
import 'package:damascent/screens/wishlist_screen.dart';
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
    CartScreen(),
    WishlistScreen(),
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
            icon: Image.asset("assets/cart.png"),
            activeIcon: Image.asset("assets/Selected_cart.png"),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/Fav.png"),
            activeIcon: Image.asset("assets/Fav.png"),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
