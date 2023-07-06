import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:wear/wear.dart';

class Dashboard_wearOS extends StatefulWidget {
  const Dashboard_wearOS({Key? key}) : super(key: key);

  @override
  State<Dashboard_wearOS> createState() => _Dashboard_wearOSState();
}

class _Dashboard_wearOSState extends State<Dashboard_wearOS> {
  var fname;
  var id;

  // shared preferences
  Future<SharedPreferences> sharedPrefs() => SharedPreferences.getInstance();

  @override
  void initState() {
    sharedPrefs().then((value) {
      setState(() {
        fname = value.getString('fname');
        id = value.getString('id');
      });
    });
    super.initState();
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
                    Text('Sparrow Dashboard',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 72, 118, 156))),
                    // divider
                    Container(
                      child: Divider(
                        color: Color.fromARGB(255, 72, 118, 156),
                        thickness: 1,
                      ),
                    ),

                    // welcome text
                    Container(
                      // axis alignment
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        // justify content
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Welcome, $fname',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          // logout button icon
                          IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "Logout Successful!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                sharedPref().removeAuthToken().then((value) =>
                                    Navigator.pushNamed(context, '/wearos'));
                              },
                              icon: Icon(Icons.exit_to_app)),
                        ],
                      ),
                    ),

                    // blue card for total questions
                    Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Total Questions',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  Text('3',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),

                              // add question button
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  key: ValueKey('addPropertyBtn'),
                                  // button color
                                  
                                  onPressed: () {
                                    
                                    Navigator.pushNamed(
                                        context, '/wearos_view');
                                  },
                                  child: Text('View Question',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
