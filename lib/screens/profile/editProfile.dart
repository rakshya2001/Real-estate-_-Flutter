import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/helpers/CherryToast.dart';
import 'package:sparrow/helpers/shared_pref.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // controller
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _secemailController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  // get data from shared pref
  var id;
  var username;
  var fname;
  var lname;
  var sec_email;
  var state;
  var district;
  var profile;
  var Image64;

  @override
  void initState() {
    sharedPref().getUserDetails().then((value) {
      setState(() {
        id = value["id"];
        username = value['username'];
        fname = value['fname'];
        lname = value['lname'];
        sec_email = value['secemail'];
        state = value['state'];
        district = value['district'];
        profile = value['profile'];
      });
    });
    super.initState();
  }

  // update profile function ApiService()

  updateProfile() {
    // if image null
    if (Image64 == null) {
      ToastService().showWarnig("Profile not selected", context);
    }

    APIService.updateProfile(
            id,
            _fnameController.text,
            _lnameController.text,
            _secemailController.text,
            _stateController.text,
            _districtController.text,
            Image64)
        .then((value) =>
            // _displayMessage(true));
            // update in shared pref
            sharedPref().setUserDetails({
              'id': id,
              'username': username,
              'fname': _fnameController.text,
              'lname': _lnameController.text,
              'secemail': _secemailController.text,
              'state': _stateController.text,
              'district': _districtController.text,
              'profile': Image64
            }));
  }

  bool showPassword = false;

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

  _displayMessage(msg) {
    if (msg) {
      MotionToast.success(description: const Text('Profile updated'))
          .show(context);
    } else {
      MotionToast.warning(
              description: const Text('Sorry man, it cannot happen'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        foregroundColor: Colors.black,
        title: Text("Change profile for @$username"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    _displayImage(),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              _loadImage(ImageSource.gallery);
                            },
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),

              // two form field in a row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // controller with initial value
                      controller: _fnameController..text = '$fname',
                      onChanged: (text) => {},
                      decoration: InputDecoration(
                        labelText: "Firstname",
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _lnameController..text = '$lname',
                      onChanged: (text) => {},
                      decoration: InputDecoration(
                        labelText: "Lastname",
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _secemailController..text = '$sec_email',
                onChanged: (text) => {},
                decoration: InputDecoration(
                  labelText: "Secondary Email Address",
                  labelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stateController..text = '$state',
                      onChanged: (text) => {},
                      decoration: InputDecoration(
                        labelText: "Province",
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _districtController..text = '$fname',
                      onChanged: (text) => {},
                      decoration: InputDecoration(
                        labelText: "District",
                        labelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // button
              ElevatedButton(
                onPressed: () {
                  updateProfile();
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget _displayImage() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: img == null
          ? NetworkImage(profile.replaceAll('localhost', '10.0.2.2'))
          : Image.file(img!).image,
    );
  }
}
