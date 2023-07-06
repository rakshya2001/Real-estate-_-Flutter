import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:wear/wear.dart';

class WOS_LoginScreen extends StatefulWidget {
  const WOS_LoginScreen({Key? key}) : super(key: key);

  @override
  State<WOS_LoginScreen> createState() => _WOS_LoginScreenState();
}

class _WOS_LoginScreenState extends State<WOS_LoginScreen> {
  // controller
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // add two text field
  int? result;
  _add() async {
    final phone = phoneController.text;
    final password = passwordController.text;
    if (phone.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all field");
    } else {
      await APIService().login(phone, password).then((value) => {
            if (value != false)
              {
                Navigator.pushNamed(context, "/wearos_dashboard"),
                Fluttertoast.showToast(
                    msg: "Access granted",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0),
              }
            else
              {
                Fluttertoast.showToast(
                    msg: "Permission Denied",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(builder: (context, mode, child) {
          return Scaffold(
            body: Center(
                child: SingleChildScrollView(
              child: SizedBox(
                
                child: Column(
                  children: [
                    Text("SPARROW AUTH"),
                    // TExt form fiels
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                        // full width button
                        key: const ValueKey("login"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          _add();
                        },
                        child: Text("Access Account")),
                  ],
                ),
              ),
            )),
          );
        });
      },
    );
  }
}
