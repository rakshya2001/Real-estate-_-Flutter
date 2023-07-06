import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/helpers/CherryToast.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:sparrow/screens/home_screen/home_screen.dart';
import 'package:sparrow/utils/config.dart';

Color colors = Colors.black;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool? isLogin;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  initState() {
    super.initState();
    _autoLogin();
  }

  _autoLogin() async {
    var token = await sharedPref().getAuthToken();
    print("token $token");
    if (token != null) {
      Navigator.pushNamed(context, '/');
    } else {
      return;
    }
  }

  _login(String phone, String password) async {
    await APIService().login(phone, password);
    sharedPref().getAuthToken().then((value) {
      print(value);
      if (value != null) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: 'basic_channel',
                title: "Login Success ",
                body: 'You are in the system !!'));
        Navigator.pushNamed(context, '/');
      } else {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: 'basic_channel',
                title: "Login Success ",
                body: 'You are in the system !!'));
        MotionToast.error(
                description: Text("Your credentials doesn't match 😒"))
            .show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // image
            Image.asset(
              'assets/images/bird.png',
              width: 77,
            ),

            Text(
              "Login to your account",
              
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                key: ValueKey("phone") ,
                controller: _emailController,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Phone number",
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextField(
                key: ValueKey("password") ,
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: colors)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: colors)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Forgot Password?",
              style: TextStyle(
                  color: colors, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 19, 33, 45),
                    Color.fromARGB(255, 114, 231, 117)
                  ])),
              margin: EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                key: ValueKey("loginBtn"),
                onPressed: () {
                  _login(_emailController.text, _passwordController.text);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "It's your first time here?",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.orange),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
