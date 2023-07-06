import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/Repository/OtheruserRepo.dart';
import 'package:sparrow/Response/OtherUserResp.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/models/otheruser_model.dart';
import 'package:sparrow/utils/Config.dart';

import '../Repository/PropertyRepo.dart';
import '../models/question_model.dart';

// getx
import 'package:get/get.dart';

class OtherUser extends StatefulWidget {
  const OtherUser({Key? key}) : super(key: key);

  // receive user id from arguments

  @override
  State<OtherUser> createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  String? userId;
  String? userName;
  var loggedInUserId;

  var ofname;
  var olname;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      loggedInUserId = prefs.getString('id');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    userId = args['id'];
    print(userId);

    OtheruserRepo().getOtherUserRepo(userId).then((value) {
      print(value);
    });

    bool isFollowed = false;

    _follow() {
      APIService.followUser(userId).then((value) {
        isFollowed = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        foregroundColor: Colors.black,
        title: Text("Viewing profile"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<OtherUserResp?>(
                future: OtheruserRepo().getOtherUserRepo(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<OtherUserModal> otherUser = snapshot.data!.data!;
                      return ListView.builder(
                        itemCount: otherUser.length,
                        itemBuilder: (context, index) {
                          RxInt followers =
                              otherUser[index].followers!.length.obs;

                          RxInt following =
                              2.obs;

                          var profile = otherUser[index].profile;

                          ofname = otherUser[index].fname;
                          olname = otherUser[index].lname;

                          return Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                // circular image
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
                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "$ofname $olname",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // description
                                Text(
                                  "@${otherUser[index].username}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),

                                // container for user details
                                Container(
                                  // white background

                                  decoration: BoxDecoration(
                                    // gredient color
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 98, 137, 255),
                                        Colors.white,
                                      ],
                                    ),

                                    // text color

                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  // padding
                                  padding: EdgeInsets.all(10),
                                  // margin
                                  margin: EdgeInsets.all(10),

                                  child: Row(
                                    // decoration

                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Obx(() {
                                            return Text(
                                              "${followers.value}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }),
                                          Text(
                                            "Followers",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${following}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Following",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // follow button
                                      isFollowed
                                          ? Container(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _follow();
                                                  followers.value++;
                                                },
                                                child: Text(
                                                  "Following",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: IconButton(
                                                  onPressed: () {
                                                    _follow();
                                                    followers.value++;
                                                    isFollowed = true;
                                                  },
                                                  icon: Icon(Icons.add_box,
                                                      color: Color.fromARGB(255, 109, 146, 255))),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  // white background

                                  // margin
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Property added by ${otherUser[index].fname}, ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          // unserline
                                        ),
                                      ),
                                      Text(
                                        "10",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("No data");
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<QuestionResponse?>(
                future: PropertyRepo().eachQuestions(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // Text
                      List<Questions> lstQuestion = snapshot.data!.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/question',
                                  arguments: {
                                    'id': lstQuestion[index].id,
                                    'fname': lstQuestion[index].postedBy!.fname,
                                    'question': lstQuestion[index].questionName,
                                    'answer': lstQuestion[index].answers,
                                    'answerCount': 12,
                                    'postedOn': lstQuestion[index].createdAt,
                                  });
                            },
                            child: Container(
                              // question container
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 59, 59, 60),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${lstQuestion[index].questionName}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${lstQuestion[index].questionImage}",
                                    width: double.infinity,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "posted on ${lstQuestion[index].createdAt}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // openDialog();
        },
        elevation: 0,
        label: const Text('Message'),
        icon: const Icon(Icons.chat_bubble_outline),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
