class Config {
  static const String apiURL = "http://10.0.2.2:5500/api";
  // static const String apiURL = "http://192.168.1.66:5500/api";
  // static const String apiURL = "http://192.168.18.196:5500/api";
  // static const String apiURL = "http://localhost:5500/api";

  static const String send_otp = "/send-otp";
  static const String verify_otp = "/verify-otp";
  static const String activate = "/activate";
  static const String login = "/login";
  static const addQuestion = "/questions";
  static const allQsn = "/allpost";
  static const postAnswer = "/answer";
  static const String getConversation = "/chat/conversation";
  static const String update_profile = "/update-profile";
  static const String searchQuestion = "/search-qsn";
  static const String changePassword = "/update-password";
  static const String getUser = "/user";
  static const String getConUser = "/con-user";
  static const String searchUser = "/search";
  static const String getMessages = "/chat/messages";
  static const String createChat = "/chat/conversation";
  static const String getEachQuestion = "/get-questions";
  static const String follow = "/follow";
  static const String like = "/like";
  static const String getConversations = "/chat/conversation";
  static const String getQuestionByQsnId = "/qnapage";
  static const String editQuestion = "/editquestion";
  static const String deleteQuestion = "/delete-question";
}
