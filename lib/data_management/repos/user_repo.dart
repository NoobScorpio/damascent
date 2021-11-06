import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<bool> logIn({required String email, required String password});
  Future<bool> updateUser(MyUser user);
  Future<bool> createAccount({required MyUser user});
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();
  @override
  Future<bool> logIn({required String email, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(baseURL + "/profile.php"));
    List<MyUser> users =
        UserResultModel.fromJson(json.decode(response.body)).users;
    for (MyUser usr in users) {
      if (usr.email == email && usr.password == password) {
        await sharedPreferences.setString('user', json.encode(usr.toJson()));
        await sharedPreferences.setBool('loggedIn', true);
        return true;
      }
    }
    showToast("Wrong email or password", Constants.primaryColor);
    return false;
  }

  @override
  Future<bool> createAccount({required MyUser user}) async {
    var resp = await http.get(Uri.parse(baseURL + "/profile.php"));
    List<MyUser> users = UserResultModel.fromJson(json.decode(resp.body)).users;
    for (MyUser usr in users) {
      if (usr.email == user.email) {
        showToast("Email already taken", Constants.primaryColor);
        return false;
      }
    }
    // debugPrint("VALUES ${{
    //   "fname": user.fName.toString(),
    //   "lname": user.lName.toString(),
    //   "email": user.email.toString(),
    //   "phone": user.phone.toString(),
    //   "country": user.country.toString(),
    //   "state": user.state.toString(),
    //   "city": user.city.toString(),
    //   "zip": user.zip.toString(),
    //   "address": user.address.toString(),
    //   "address1": user.address1.toString(),
    //   "password": user.password.toString(),
    // }}");
    var response = await http.post(Uri.parse(baseURL + "/create.php"),
        body: json.encode({
          "fname": user.fName.toString(),
          "lname": user.lName.toString(),
          "email": user.email.toString(),
          "phone": user.phone.toString(),
          "country": user.country.toString(),
          "state": user.state.toString(),
          "city": user.city.toString(),
          "zip": user.zip.toString(),
          "address": user.address.toString(),
          "address1": user.address1.toString(),
          "password": user.password.toString(),
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // debugPrint("${json.decode(response.body)['message']}");
      SharedPreferences sp = await SharedPreferences.getInstance();
      var resp = await http.get(Uri.parse(baseURL + "/profile.php"));
      List<MyUser> users =
          UserResultModel.fromJson(json.decode(resp.body)).users;
      for (MyUser usr in users) {
        if (usr.email == user.email) {
          user = usr;
        }
      }
      await sp.setString('user', json.encode(user.toJson()));
      await sp.setBool('loggedIn', true);
      // debugPrint("RETURNING API ${json.decode(response.body)['message']}");
      return true;
    } else if (response.statusCode == 400) {
      // debugPrint(response.body.toString());
      showToast(json.decode(response.body)['message'], Constants.primaryColor);
      return false;
    } else if (response.statusCode == 500) {
      showToast('Internal server error.', Constants.primaryColor);

      return false;
    } else {
      showToast('Something went wrong', Constants.primaryColor);
      return false;
    }
  }

  @override
  Future<bool> updateUser(MyUser user) async {
    var response = await http.post(Uri.parse(baseURL + "/update.php"),
        body: user.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('user', json.encode(user.toJson()));
      return true;
    } else if (response.statusCode == 400) {
      showToast(json.decode(response.body)['message'], Constants.primaryColor);
      return false;
    } else if (response.statusCode == 500) {
      showToast(json.decode(response.body)['message'], Constants.primaryColor);
      return false;
    } else {
      showToast(json.decode(response.body)['message'], Constants.primaryColor);
      return false;
    }
  }
}
