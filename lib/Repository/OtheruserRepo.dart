import 'dart:io';
import 'package:sparrow/Response/OtherUserResp.dart';
import 'package:sparrow/api/api_service.dart';

class OtheruserRepo {

  Future<OtherUserResp?> getOtherUserRepo(id) async {
    OtherUserResp? otherUserResp;
    try {
      otherUserResp = await APIService().getUserProfile(id);
    } catch (e) {
      print(e);
    }
    return otherUserResp;
  }

}

