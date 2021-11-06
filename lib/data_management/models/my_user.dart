class MyUser {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? zip;
  String? address;
  String? address1;
  String? password;
  String? id;
  MyUser(
      { this.fName,
        this.lName,
        this.email,
        this.phone,
        this.country,
        this.state,
        this.city,
        this.zip,
        this.address,
        this.address1,
        this.id,
        this.password});

  MyUser.fromJson(Map<String, dynamic> json) {
    fName = json['fname'];
    id = json['id'];
    lName = json['lname'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'] ?? "";
    zip = json['zip'];
    address = json['address'];
    address1 = json['address1'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fname'] = fName;
    data['id'] = id;
    data['lname'] = lName;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['zip'] = zip;
    data['address'] = address;
    data['address1'] = address1;
    data['password'] = password;
    return data;
  }
}

class UserResultModel {
  late List<MyUser> users;

  UserResultModel({required this.users});

  UserResultModel.fromJson(Map<String, dynamic> json) {
    users = <MyUser>[];
    json['records'].forEach((v) {
      users.add(MyUser.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users'] = users.map((v) => v.toJson()).toList();
    return data;
  }
}
