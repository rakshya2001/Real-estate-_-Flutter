import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetails extends StatefulWidget {
  const ChatDetails({Key? key}) : super(key: key);
  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<ChatMessage> messages = [];
  final TextEditingController _textController = TextEditingController();
  var loginedUser;
  String? OtherUser;
  String? id;

  _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginedUser = prefs.getString('id');
  }

  // socket
  final IO.Socket socket = IO.io('http://192.168.1.66:5500',
      IO.OptionBuilder().setTransports(['websocket']).build());

  _sendMessageThroughSocket() {
    print("Sending message through socket");
    socket.emit("send-msg", {
      'from': loginedUser,
      'to': OtherUser,
      'msg': _textController.text,
    });
  }

  _connectSocket() {
    _getId();
    print("SOcket init");
    IO.Socket socket = IO.io('http://192.168.1.66:5500',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((data) {
      print('connected');
      print("USER ID FOR SOCKET: $loginedUser");
      socket.emit('add-user', loginedUser);
    });
    socket.onConnectError((data) => print(data));
    socket.on('new-msg', (data) {
      print("Message received through socket iiii");
      print(data);

      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          // make changes here
          messages.clear();
          messages.add(ChatMessage(
            messageContent: data['text'],
            messageType: "receiver",
            username: "you",
          ));
        });
      }
    });
  }

  @override
  void initState() {
    _connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    OtherUser = args['receiverId'];
    id = args['senderId'];

    Map ids = args['ids'];
    id = ids['senderId'];
    OtherUser = ids['receiverId'];

    List chat = args['chatMessages'];

    for (int i = 0; i < chat.length; i++) {
      // clear messages
      if (chat[i]['sender'] == id) {
        messages.add(ChatMessage(
            messageContent: chat[i]['text'],
            messageType: "sender",
            username: "You"));
      } else {
        messages.add(ChatMessage(
            messageContent: chat[i]['text'],
            messageType: "receiver",
            username: "Kriss"));
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            // clear messages
            messages.clear();
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Chat Screen",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Color.fromARGB(255, 110, 109, 109)
                            : Color.fromARGB(255, 70, 73, 252)),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _sendMessageThroughSocket();

                        //add message to messages at the last index
                        messages.add(ChatMessage(
                            messageContent: _textController.text,
                            messageType: "sender",
                            username: "You"));
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.grey,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
