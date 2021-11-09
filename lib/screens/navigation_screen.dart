import 'package:damascent/screens/cart_screen.dart';
import 'package:damascent/screens/home_screen.dart';
import 'package:damascent/screens/wishlist_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(id: widget.id),
      const CartScreen(),
      BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadedState) {
          if (state.user.id == "" || state.user.id == null) {
            return const WishlistScreen(id: "");
          }
          return WishlistScreen(id: state.user.id ?? "");
        } else {
          return const WishlistScreen(id: "");
        }
      }),
    ];
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
