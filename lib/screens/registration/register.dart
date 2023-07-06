import 'package:flutter/material.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:logger/logger.dart';

Color colors = Colors.black;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _globalkey = GlobalKey<FormState>();

  var logger = Logger();
  String? mobileNo;
  String? hash;
  bool isAPICallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/email.png',
              width: 70,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Enter your phone number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                onChanged: (value) => {mobileNo = value},
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  hintText: "98########",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: colors)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: colors)),
                  suffixIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  // call api and get hash and phone number
                  APIService.SendOtp(mobileNo!).then((value) {
                    Navigator.pushNamed(context, '/otp', arguments: value);
                  });
                },
                child: const Text(
                  'Get code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "We will send you a verification code",
              style: TextStyle(
                  color: Color.fromARGB(255, 195, 195, 195), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
