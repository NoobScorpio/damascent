import 'dart:convert';
import 'dart:io';
import 'package:damascent/data_management/models/cart.dart';
import 'package:damascent/data_management/models/cart_item.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/data_management/models/user.dart';
import 'package:damascent/data_management/repos/user_repo.dart';
import 'package:damascent/state_management/user/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  // final bool initial;
  // final User user;
  UserCubit({required this.userRepository}) : super(UserInitialState());

  Future<bool> loginUser(String email, String pass) async {
    try {
      emit(UserLoadingState());
      bool user = await userRepository.logIn(email: email, password: pass);
      if (user) {
        var sp = await SharedPreferences.getInstance();
        var usrString = sp.getString('user') ?? '';
        MyUser u = MyUser.fromJson(json.decode(usrString));
        emit(UserLoadedState(user: u));
        return true;
      } else {
        emit(UserErrorState(message: 'Unable to login'));
        return false;
      }
    } on Exception {
      emit(UserErrorState(message: "Unable to login"));
      return false;
    }
  }

  Future<bool> createUser({required MyUser user}) async {
    try {
      emit(UserLoadingState());
      debugPrint("CREATE USER: ${user.toJson()}");
      bool created = await userRepository.createAccount(user: user);
      if (created) {
        var sp = await SharedPreferences.getInstance();
        var usrString = sp.getString('user') ?? '';
        // debugPrint("USER STRING $usrString");
        var js = json.decode(usrString);
        // debugPrint("USER JSON $js");
        MyUser u = MyUser.fromJson(js);
        // debugPrint("USER ${u.toJson()}");
        emit(UserLoadedState(user: u));
        return true;
      } else {
        emit(UserErrorState(message: 'Unable to create User'));
        return false;
      }
    } catch (e) {
      emit(UserErrorState(message: "Unable to create User"));
      debugPrint("$e");
      return false;
    }
  }

  Future<void> getUser() async {
    try {
      var sp = await SharedPreferences.getInstance();
      var usrString = sp.getString('user') ?? '';
      MyUser u = MyUser.fromJson(json.decode(usrString));
      if (u.email != "") {
        emit(UserLoadedState(user: u));
      } else {
        emit(UserInitialState());
      }
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
    }
  }

  Future<bool> updateProfile({required MyUser user}) async {
    try {
      bool updated = await userRepository.updateUser(user);

      if (updated) {
        var sp = await SharedPreferences.getInstance();
        var usrString = sp.getString('user') ?? '';
        MyUser u = MyUser.fromJson(json.decode(usrString));
        emit(UserLoadedState(user: u));
        return true;
      } else {
        return false;
      }
    } on Exception {
      emit(UserErrorState(message: "Could not get user"));
      return false;
    }
  }

  logOut() async {
    try {
      emit(UserLoadingState());
      var sp = await SharedPreferences.getInstance();
      await sp.setString('user', json.encode(MyUser().toJson()));
      var cart = MyCart();
      cart.cartItem = [];
      await sp.setString('cart', json.encode(cart.toJson()));

      emit(UserLoadedState(user: MyUser()));
    } on Exception {
      emit(UserErrorState(message: "Could not logout"));
    }
  }
}
