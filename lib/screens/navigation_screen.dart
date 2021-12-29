import 'package:damascent/constants/constants.dart';
import 'package:damascent/screens/cart_screen.dart';
import 'package:damascent/screens/home_screen.dart';
import 'package:damascent/screens/wishlist_screen.dart';
import 'package:damascent/state_management/cart/cart_cubit.dart';
import 'package:damascent/state_management/cart/cart_state.dart';
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
         const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: Colors.white,size: 30,),
            activeIcon:  Icon(Icons.home,color: Colors.white,size:30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<CartCubit,CartState>(
                builder: (context,state) {

                  if(state is CartLoadedState ){
                    int len=0;
                    for(var item in state.cartItems){
                      len+=item.qty;
                    }
                    return getCartIcon(len,Icons.shopping_bag_outlined);
                  }
                  else if(state is CartLoadedState ){
                    int len=0;
                    for(var item in state.cartItems){
                      len+=item.qty;
                    }
                    return getCartIcon(len,Icons.shopping_bag_outlined);
                  }else{
                    return const Icon(Icons.shopping_bag_outlined ,color: Colors.white,size: 30,);
                  }
                }
            ),
            activeIcon: BlocBuilder<CartCubit,CartState>(
              builder: (context,state) {

                if(state is CartLoadedState ){
                  int len=0;
                  for(var item in state.cartItems){
                    len+=item.qty;
                  }
                  return getCartIcon(len,Icons.shopping_bag);

                }
                else if(state is CartLoadedState ){
                  int len=0;
                  for(var item in state.cartItems){
                    len+=item.qty;
                  }
                  return getCartIcon(len,Icons.shopping_bag);
                }else{
                  return const Icon(Icons.shopping_bag ,color: Colors.white,size: 30,);
                }
              }
            ),
            label: 'School',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined ,color: Colors.white,size: 30,),
            activeIcon:  Icon(Icons.favorite ,color: Colors.white,size: 30,),
            label: 'Wish list',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  Widget getCartIcon(len,icon){
    return Stack(
      children: [

          Center(child:  Icon(icon ,color: Colors.white,size: 30,),),
        Positioned(
          top:0,
          right:0,
          left: 20,
          child: CircleAvatar(

            child: Text(len.toString(),style:const TextStyle(
              color: Colors.white,
              fontSize:
              12,
            ),),backgroundColor:Constants.primaryColor,radius: 8,
          ),
        ),
      ],
    );
  }
}
