import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/utils/config.dart';

class PropertyAPI {
  // Add question
  Future<bool> addProperty(String? image, String? qsn) async {
    try {
      var url = Config.apiURL + Config.addQuestion;
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      await dio.post(url,
          data: {"questionName": qsn, "qsnPhoto": image},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuestionResponse?> getQuestions() async {
    QuestionResponse? questionResponse;
    Future.delayed(const Duration(seconds: 5), () {});
    var url = Config.apiURL + Config.allQsn; // test url
    var dio = Dio();
    // hive box
    Box box;
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('test');

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 201) {
        String postdata = jsonEncode(response.data);
        await box.clear();
        box.put("qsn", postdata);
        questionResponse = QuestionResponse.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    // ignore: non_constant_identifier_names
    } catch (SocketException) {
      print("Loading data from Hive Storage");
      var stored = box.get("qsn");
      var encoded = jsonDecode(stored);
      questionResponse = QuestionResponse.fromJson(encoded);
    }

    return questionResponse;
  }

  // post answers to server
  Future<bool> postAnswers(String? qsnId, String? ans) async {
    try {
      var url = Config.apiURL + Config.postAnswer;
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      await dio.post(url,
          data: {"questionId": qsnId, "answer": ans},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }

  // like question
  Future<bool> like(String? qsnId) async {
    try {
      var url = Config.apiURL + Config.like;
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      await dio.put(url,
          data: {"questionId": qsnId},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }

  // search questions
  Future<QuestionResponse?> searchQuestions(String? qsn) async {
    QuestionResponse? questionResponse;
    try {
      var url = Config.apiURL + Config.searchQuestion;
      var dio = Dio();
      Response response = await dio.post(
        url,
        data: {"questionName": qsn},
      );
      if (response.statusCode == 201) {
        questionResponse = QuestionResponse.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return questionResponse;
  }

  // get question by user id
  Future<QuestionResponse?> getQuestionByUserId(String? userId) async {
    QuestionResponse? questionResponse;
    try {
      var url = Config.apiURL + '${Config.getEachQuestion}/$userId';
      print(url);
      var dio = Dio();
      Response response = await dio.get(url);
      if (response.statusCode == 201) {
        questionResponse = QuestionResponse.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return questionResponse;
  }

  // get question by question id
  Future getQuestionByQsnId(String? qsnId) async {
    try {
      var url = Config.apiURL + '${Config.getQuestionByQsnId}/$qsnId';
      var dio = Dio();
      Response response = await dio.get(url);
      if (response.statusCode == 201) {
        return response.data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // edit question by question id
  Future<bool> editQuestion(String? id, String? updatedQsn) async {
    try {
      var url = Config.apiURL + Config.editQuestion;
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      await dio.post(url,
          data: {"questionId": id, "questionName": updatedQsn},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }

  // delete question by params id
  Future<bool> deleteQuestion(String? id) async {
    try {
      var url = Config.apiURL + Config.deleteQuestion + "/$id";
      var dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      await dio.delete(url,
          data: {"questionId": id},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }
}