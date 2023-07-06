import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:provider/provider.dart';
import 'package:sparrow/api/api_service.dart';
import 'package:sparrow/api/chat_api.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';
import 'package:sparrow/screens/chat_screen/chatDetails.dart';
import 'package:sparrow/utils/Config.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var index = 0;

  @override
  void initState() {
    // TODO: implement initState
    // initPlatformState();
    super.initState();
  }

  _loadConversation() {
    ChatAPI().getConversation();
  }

  final TextEditingController _searchController = TextEditingController();

  String _searchText = "";

  String _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
    });
    final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    if (luxValue < 15) {
      provider.toggleTheme(true);
    } else {
      provider.toggleTheme(false);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        foregroundColor: Colors.black,
        title: const Text("Messenger",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: FutureBuilder(
        future: ChatAPI().getConversation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child:
                    // no internet connection
                    Text("No Conversation"));
          }

          final List conversations = snapshot.data as List;
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              // final profile = conversations[index]['_id'];

              print(conversations);

              return ListTile(
                // circular avatar
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                ),
                title: Text('@${conversations[index]['username']}'),
                // subtitle: Text(conversations[index]['username']),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  ChatAPI()
                      .getMessages(conversations[index]['_id'])
                      .then((value) => Navigator.pushNamed(
                            context,
                            "/chat_detail",
                            arguments: {
                              "chatMessages": value,
                              "ids": {
                                "senderId": conversations[index]['senderId'],
                                "receiverId": conversations[index]
                                    ['receiverId'],
                              },
                            },
                          ));
                },
              );
            },
          );
        },
      ),
      endDrawer: Drawer(
        elevation: 0,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: DrawerHeader(
                  child: Column(
                    children: [
                      const Text(
                        "Search users",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // copertino search bar
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _searchController
                            ..addListener(() {
                              setState(() {
                                _searchText = _searchController.text;
                              });
                            }),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search",
                          ),
                        ),
                      ),

                      // List of users
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: APIService().searchUser(_searchText),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No users found"));
                    }
                    final List users = snapshot.data as List;

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final profile = users[index]['profile'];
                        return ListTile(
                          leading: Config.apiURL.contains("10.0.2.2")
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(profile
                                      .replaceAll('localhost', '10.0.2.2')),
                                  // height and width
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("https://i.pravatar.cc/300"),
                                ),
                          title: Text(
                              "${users[index]['fname']} ${users[index]['lname']} "),
                          subtitle: Text('@ ${users[index]['username']}'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.pushNamed(context, '/other', arguments: {
                              'id': users[index]['_id'],
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList(
      {Key? key,
      required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead})
      : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatDetails();
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
