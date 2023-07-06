import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sparrow/api/api_service.dart';

Color colors = Color.fromARGB(255, 122, 122, 122);

class ActivateScreen extends StatefulWidget {
  const ActivateScreen({Key? key}) : super(key: key);

  @override
  State<ActivateScreen> createState() => _ActivateScreenState();
}

class _ActivateScreenState extends State<ActivateScreen> {
  String? username;
  String? password;
  String? conf_password;
  String? userId;

  _activate() {
    if (username == null || password == null || conf_password == null) {
      MotionToast.error(description: Text('Fill all the feilds!'))
          .show(context);
    }
    if (password != conf_password) {
      MotionToast.error(description: Text('Password does not match'))
          .show(context);
    } else {
      APIService.Activate(username!, password!, userId!).then((value) {
        Navigator.pushNamed(context, '/login');
        MotionToast.success(description: Text("Account Activated, Login now!"))
            .show(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    userId = args['id'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Image.asset(
                'assets/images/verified.png',
                width: 77,
              ),
        
              Text(
                "Email Verified",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              
        
              Text(
                "We need something more from you!",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  onChanged: (value) {
                    username = value;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Create a username",
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
        
              // text
              Text(
                "Create a strong password combination",
                style: TextStyle(color: Color.fromARGB(255, 241, 124, 124)),
              ),
               SizedBox(
                height: 10,
              ),
              
        
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "New Password",
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
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  onChanged: (value) {
                    conf_password = value;
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Confirm Password",
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
              
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    _activate();
                  
                  },
                  child: const Text(
                    'Activate Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
