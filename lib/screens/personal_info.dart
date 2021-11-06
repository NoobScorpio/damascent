import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:damascent/data_management/models/my_user.dart';
import 'package:damascent/screens/navigation_screen.dart';
import 'package:damascent/state_management/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation(
      {Key? key, required this.user, required this.checkOut})
      : super(key: key);
  final MyUser user;
  final bool checkOut;
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late MyUser user;
  TextEditingController fName = TextEditingController(),
      lName = TextEditingController(),
      email = TextEditingController(),
      pass = TextEditingController(),
      phone = TextEditingController(),
      city = TextEditingController(),
      state = TextEditingController(),
      country = TextEditingController(),
      address = TextEditingController(),
      address2 = TextEditingController(),
      zip = TextEditingController();
  @override
  void initState() {
    super.initState();
    user = widget.user;
    fName.text = user.fName!;
    lName.text = user.lName!;
    email.text = user.email!;
    phone.text = user.phone!;
    address.text = user.address!;
    address2.text = user.address1!;
    city.text = user.city!;
    country.text = user.country!;
    state.text = user.state!;
    zip.text = user.zip!;
  }

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
              const SizedBox(
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
                    child: const BackButton(),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Personal Information",
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
              const SizedBox(
                height: 25,
              ),
              //HEADER
              getTextFieldProfile(email, "Email"),
              const SizedBox(
                height: 25,
              ),
              getTextFieldProfile(phone, "Phone"),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Shipping address",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              //FIRST LAST NAME
              Row(
                children: [
                  Expanded(
                    child: getTextFieldProfile(fName, "First Name"),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: getTextFieldProfile(lName, "Last Name"),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              //ADDRESS
              getTextFieldProfile(address, "Address"),
              const SizedBox(
                height: 15,
              ),
              getTextFieldProfile(address2, "Address2"),
              const SizedBox(
                height: 15,
              ),
              //LOCATION
              Row(
                children: [
                  Expanded(
                    child: getTextFieldProfile(city, "City"),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: getTextFieldProfile(state, "State"),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: getTextFieldProfile(country, "Country"),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: getTextFieldProfile(zip, "Postal Code"),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    showToast("Saving Data", Constants.primaryColor);

                    if (fName.text != "" &&
                        lName.text != "" &&
                        email.text != "" &&
                        state.text != "" &&
                        country.text != "" &&
                        city.text != "" &&
                        phone.text != "" &&
                        zip.text != "" &&
                        address.text != "" &&
                        address2.text != "") {
                      // debugPrint(zip.text.toString());
                      bool updated = await BlocProvider.of<UserCubit>(context)
                          .updateProfile(
                              user: MyUser(
                                  fName: fName.text.toString(),
                                  lName: lName.text.toString(),
                                  email: email.text.toString(),
                                  state: state.text.toString(),
                                  password: user.password,
                                  country: country.text.toString(),
                                  city: city.text.toString(),
                                  phone: phone.text.toString(),
                                  zip: zip.text.toString(),
                                  address: address.text.toString(),
                                  address1: address2.text.toString(),
                                  id: user.id));
                      if (updated) {
                        showToast("Success", Constants.primaryColor);

                        pop(context);
                        if (!widget.checkOut) {
                          pop(context);
                        }
                      }
                    } else {
                      showToast(
                          "Please fill all fields", Constants.primaryColor);
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Save",
                          style: Constants.avgStyleBold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
