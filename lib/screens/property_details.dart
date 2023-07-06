import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/api/PropertyAPI.dart';
import 'package:sparrow/api/chat_api.dart';
import 'package:sparrow/screens/BottomNav/BottomNav.dart';
import 'package:sparrow/utils/Config.dart';
import 'package:timeago/timeago.dart' as timeago;

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  var qsnId;
  // answer controller
  TextEditingController answerController = TextEditingController();

  bool _isLoading = false;
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

  // const createChat = (user) => {
  //       createConversation({ senderId: id, receiverId: _id }).then(res => {
  //           console.log("Got it", res);
  //       });

  //       navigate('/message');
  //   }

  String? receiverId;
  String? username;
  void createChat() async {
    try {
      // get id from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? senderId = prefs.getString("id");

      ChatAPI().createChat(senderId!, receiverId!, username!);
      print('Convo Created');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    qsnId = args['id'];
    receiverId = args['postedById'];
    username = args['username'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Detail page'),
      ),
      body: FutureBuilder(
        future: PropertyAPI().getQuestionByQsnId(qsnId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final List qna = snapshot.data as List;
          return ListView.builder(
            itemCount: qna.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // question details page
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        '${args['fname']} asked about ${timeago.format(DateTime.parse(qna[index]['createdAt']))}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        '${qna[index]['questionName']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        'PRICE: NPR 123',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CachedNetworkImage(
                          imageUrl: qna[index]['questionImage']),
                    ),
                  ],
                  // floating action button
                ),
              );
            },
          );
        },
      ),
      // full length floating action button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createChat();
        },
        elevation: 0,
        label: const Text('Chat'),
        icon: const Icon(Icons.chat),
        backgroundColor: Color.fromARGB(255, 56, 55, 55),
        foregroundColor: Colors.white,
      ),
    );
  }
}
