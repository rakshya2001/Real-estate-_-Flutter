import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/PropertyAPI.dart';

class PropertyRepo {
  Future<QuestionResponse?> getQuestions() async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await PropertyAPI().getQuestions();
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }
  
  Future<QuestionResponse?> searchQuestions(qsn) async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await PropertyAPI().searchQuestions(qsn);
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }

   Future<QuestionResponse?> eachQuestions(userId) async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await PropertyAPI().getQuestionByUserId(userId);
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }
}

