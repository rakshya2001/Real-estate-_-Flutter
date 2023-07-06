import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/Repository/PropertyRepo.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/models/question_model.dart';
import 'package:wear/wear.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewQsn_WearOS extends StatefulWidget {
  const ViewQsn_WearOS({Key? key}) : super(key: key);

  @override
  State<ViewQsn_WearOS> createState() => _ViewQsn_WearOSState();
}

class _ViewQsn_WearOSState extends State<ViewQsn_WearOS> {
  var loginedUser;

  // shared preferences
  Future<SharedPreferences> sharedPref() => SharedPreferences.getInstance();

  @override
  void initState() {
    sharedPref().then((value) {
      setState(() {
        loginedUser = value.getString('id');
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
                    child: FutureBuilder<QuestionResponse?>(
                        future: PropertyRepo().eachQuestions(loginedUser),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              // Text
                              List<Questions> lstQuestion =
                                  snapshot.data!.data!;

                              // for loop to get each question
                              

                              return Column(
                                children: [
                                  const Text('Showing all questions',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 72, 118, 156))),
                                  // divider
                                  const Divider(
                                    color:
                                        Color.fromARGB(255, 72, 118, 156),
                                    thickness: 1,
                                  ),
                                  for (var i = 0; i < lstQuestion.length; i++) 
                                  Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: CachedNetworkImageProvider(
                                            lstQuestion[i].questionImage!),
                                      ),
                                      title: Text(
                                        lstQuestion[i].questionName!,
                                        style: TextStyle(
                                            fontSize: 8,
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: Text("No Data"),
                              );
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                radius: 20,
                              ),
                            );
                          } else {
                            return const Text("Error");
                          }
                        })
                  
                    )),
          );
        });
      },
    );
  }
}
