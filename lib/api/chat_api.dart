import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/utils/config.dart';

class ChatAPI {
  Future getConversation() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = prefs.getString("id");
    var conversationURL =
        Config.apiURL + '${Config.getConversation}/$currentUser';

    // list of conversation
    // List conversationList = [];

    try {
      var response = await dio.get(conversationURL);
      // for (int i = 0; i < response.data.length; i++) {
      //   var members = response.data[i]['members'];
      //   // choosing other member of the conversation
      //   var otherUser = members.firstWhere((element) => element != currentUser);
      //   var userURL = Config.apiURL + '${Config.getConUser}/$otherUser';
      //   Response userResponse = await dio.get(userURL);
      //   conversationList.add(userResponse.data);
      // }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future getMessages(String conversationId) async {
    print(conversationId);
    var dio = Dio();
    var messagesURL = Config.apiURL + '${Config.getMessages}/$conversationId';
    try {
      var response = await dio.get(messagesURL);
      print(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future createChat(String senderId, String receiverId, String username) async {
    var dio = Dio();
    var createChatURL = Config.apiURL + Config.createChat;
    try {
      var response = await dio.post(createChatURL,
          data: {"senderId": senderId, "receiverId": receiverId, "username": username});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  Future searchUser(String otherUser) async {
    var dio = Dio();
    List conversationList = [];
    var userURL = Config.apiURL + '${Config.getConUser}/$otherUser';
    try {
      var response = await dio.get(userURL);
      conversationList.add(response.data);
      return conversationList;
    } catch (e) {
      rethrow;
    }
  }
}
