import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:sparrow/Repository/OtheruserRepo.dart';
import 'package:sparrow/Response/OtherUserResp.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:sparrow/models/otheruser_model.dart';
import '../../utils/Config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var username;
  var fname;
  var profile;
  List followers = [];
  var id;

  late ShakeDetector detector;

  @override
  void initState() {
    sharedPref().getUserDetails().then((value) {
      setState(() {
        id = value['id'];
      });
    });

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _showAlertDialog(context);
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              sharedPref()
                  .removeAuthToken()
                  .then((value) => Navigator.pushNamed(context, '/login'));
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text('Settings and Privacy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    sharedPref()
                  .removeAuthToken()
                  .then((value) => Navigator.pushNamed(context, '/login'));
                  },
                )
              
              ],
        ),
        body: Container(
          child: FutureBuilder<OtherUserResp?>(
            future: OtheruserRepo().getOtherUserRepo(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<OtherUserModal> otherUser = snapshot.data!.data!;
                  return ListView.builder(
                    itemCount: otherUser.length,
                    itemBuilder: (context, index) {
                      var profile = otherUser[index].profile;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Config.apiURL.contains("10.0.2.2")
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(profile!
                                            .replaceAll(
                                                'localhost', '10.0.2.2',)),
                                        // height and width
                                        minRadius: 40,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://i.pravatar.cc/300"),
                                            minRadius: 40,
                                      ),
                                Container(
                                  child: Column(
                                    // alignment: Alignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${otherUser[index].fname} ${otherUser[index].lname}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "@${otherUser[index].username}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                         
                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // background color
                            
                            child: SettingsGroup(
                              
                              items: [
                                SettingsItem(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/edit_profile');
                                  },
                                  icons: CupertinoIcons.settings,
                                  iconStyle: IconStyle(),
                                  title: 'Customize your profile',
                                  subtitle: "Edit your profile settings ",
                                  
                                ),
                                SettingsItem(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/change_password');
                                  },
                                  icons: CupertinoIcons.lock,
                                  iconStyle: IconStyle(),
                                  title: 'Privacy and safety',
                                  subtitle: "Password and security settings",
                                ),
                                SettingsItem(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/editQsn');
                                  },
                                  icons: Icons.question_answer,
                                  iconStyle: IconStyle(
                                    iconsColor: Colors.white,
                                    withBackground: true,
                                    backgroundColor: Colors.red,
                                  ),
                                  title: 'Your Added Property',
                                  subtitle: "Edit and delete",
                                ),
                                 
                                SettingsItem(
                                  onTap: () {},
                                  icons: Icons.dark_mode_rounded,
                                  iconStyle: IconStyle(
                                    iconsColor: Colors.white,
                                    withBackground: true,
                                    backgroundColor: Colors.red,
                                  ),
                                  title: 'Dark mode',
                                  subtitle: "Automatic",
                                  trailing: Switch.adaptive(
                                    value: themeProvider.isDarkMode ,
                                    onChanged: (value) {
                                      final provider = Provider.of<ThemeProvider>(
                                        context,
                                        listen: false,
                                      );
                                      provider.toggleTheme(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          OutlinedButton(
                            // outline border
                            style: OutlinedButton.styleFrom(
                              primary: Color.fromARGB(255, 235, 25, 25),
                              // border color
                              minimumSize: const Size.fromHeight(45), // NEW
                            ),
                            onPressed: () {
                              _showAlertDialog(context);
                            },
                            child: const Text('Logout'),
                          ),

                          // add button to the left side of the screen
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No profile data"));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      );
  }
}
