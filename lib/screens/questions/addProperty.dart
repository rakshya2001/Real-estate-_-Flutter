import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sparrow/api/PropertyAPI.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/helpers/shared_pref.dart';

import '../../utils/Config.dart';

class addProperty extends StatefulWidget {
  const addProperty({Key? key}) : super(key: key);

  @override
  State<addProperty> createState() => _addPropertyState();
}

class _addPropertyState extends State<addProperty> {
  final _globalkey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  String? qsn;
  var fname;
  var lname;
  var profile;
  String? Image64;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64," + base64Encode(bytes);

      if (image != null) {
        setState(() {
          img = File(image.path);
          Image64 = base64Image;
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  @override
  void initState() {
    sharedPref().getUserDetails().then((value) {
      setState(() {
        fname = value['fname'];
        lname = value['lname'];
        profile = value['profile'];
      });
    });
    super.initState();
  }

  _addProperty() {
    print(qsn!);
    PropertyAPI()
        .addProperty(Image64, qsn)
        .then((value) => _displayMessage(true));
  }

  _displayMessage(msg) {
    if (msg) {
      MotionToast.success(description: const Text('Property has been added!'))
          .show(context);
    } else {
      MotionToast.warning(description: const Text('error product register'))
          .show(context);
    }
  }

  bool _isLoading = false;
  // This function will be triggered when the button is pressed
  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });

    // Wait for 3 seconds
    // You can replace this with your own task like fetching data, proccessing images, etc
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Add Property...'),

        // button
        actions: [
          IconButton(
            icon: _isLoading
                ? CupertinoActivityIndicator()
                : Icon(Icons.post_add_outlined),
            onPressed: () {
              onPressed:
              _isLoading ? null : _startLoading();
              _addProperty();
            },
          ),
        ],
      ),
      // Scrollview
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Config.apiURL.contains("10.0.2.2")
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              profile.replaceAll('localhost', '10.0.2.2')),
                          // height and width
                          minRadius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage("https://i.pravatar.cc/300"),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '$fname $lname',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Public',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // textarea for question
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                onChanged: (value) => qsn = value,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Describe your property',
                ),
              ),
            ),
            _displayImage(),
          ],

          // bottom navigation bar
        ),
      ),
      // icon navigation bar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.camera_rotate),
            label: 'Open',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections),
            label: 'Gallary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[800],
        onTap: (int index) {
          if (index == 0) _loadImage(ImageSource.camera);
          if (index == 1) _loadImage(ImageSource.gallery);
        },
      ),
    );
  }

  Widget _displayImage() {
    return Card(
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(5.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              img == null
                  ? Icon(
                      Icons.image,
                      size: 200,)
                  : Image.file(img!),
            ],
          ),
        ),
      ),
    );
  }
}
