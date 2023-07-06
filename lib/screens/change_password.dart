import 'package:flutter/material.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/helpers/shared_pref.dart';

Color colors = Colors.black;
Color msgColor = Colors.black;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // controllers
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? message = "Create a strong secure password";
  String? id = "";

  // get id from shared prefs
  @override
  void initState() {
    sharedPref().getUserDetails().then((value) {
      setState(() {
        id = value['id'];
      });
    });
    super.initState();
  }

  // realtime validation
  _changePassword() {
    if (_oldPasswordController.text.isEmpty) {
      setState(() {
        colors = Colors.red;
        msgColor = Colors.red;
        message = "Old password is required";
      });
    } else if (_newPasswordController.text.isEmpty) {
      setState(() {
        colors = Colors.red;
        msgColor = Colors.red;
        message = "New password is required";
      });
    } else if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        colors = Colors.red;
        msgColor = Colors.red;
        message = "Confirm password is required";
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        colors = Colors.red;
        msgColor = Colors.red;
        message = "New password and confirm password must be same";
      });
    } else {
      APIService.changePassword(
              id, _oldPasswordController.text, _newPasswordController.text)
          .then((value) {
             setState(() {
        colors = Colors.green;
        msgColor = Colors.green;
        message = "Password changed successfully";
      });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        foregroundColor: Colors.black,
        title: Text("Change your password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/key.png',
            width: 70,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "brand new password",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
           Text(
            "$message",
            style: TextStyle(color: msgColor, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              // onChanged: (value) => {mobileNo = value},
              key: const ValueKey("oldPassword"),
              controller: _oldPasswordController,
              obscureText: true,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Current passcode",
                hintStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              key: const ValueKey("newPassword"),
              controller: _newPasswordController,
              obscureText: true,
              // onChanged: (value) => {mobileNo = value},
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: "New passcode",
                hintStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              key: const ValueKey("confirmPassword"),
              controller: _confirmPasswordController,
              // onChanged: (value) => {mobileNo = value},
              obscureText: true,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Confirm new passcode",
                hintStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: colors)),
              ),
            ),
          ),
      
          // realtime validation for the password
      
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: ElevatedButton(
              key: const ValueKey("changePasswordBtn"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                // call api and get hash and phone number
                // APIService.SendOtp(mobileNo!).then((value) {
                //   Navigator.pushNamed(context, '/otp', arguments: value);
                // });
                _changePassword();
              },
              child: const Text(
                'Change password',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          
        ],
      ),
    );
  }
}
