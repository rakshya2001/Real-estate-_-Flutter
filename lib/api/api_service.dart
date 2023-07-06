import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparrow/Response/OtherUserResp.dart';
import 'package:sparrow/helpers/shared_pref.dart';
import 'package:sparrow/models/otp_response.dart';
import 'package:logger/logger.dart';
import 'package:sparrow/utils/Config.dart';

class APIService {
  static var client = http.Client();
  // ignore: non_constant_identifier_names
  static Future<OtpHashData> SendOtp(String mobileNo) async {
    var sendOtp = Config.apiURL + Config.send_otp;
    try {
      var response = await Dio().post(sendOtp, data: {'phone': mobileNo});
      return OtpHashData.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // ignore: non_constant_identifier_names
  static Future VerifyOtp(String hash, String otp, String phone) async {
    var logger = Logger();
    var verifyOtp = Config.apiURL + Config.verify_otp;

    try {
      var response = await Dio().post(
        verifyOtp,
        data: {'hash': hash, 'userOtp': otp, 'phone': phone},
      );
      return response.data;
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  // ignore: non_constant_identifier_names
  static Future Activate(
      String username, String password, String userId) async {
    var dio = Dio();
    var activateURL = Config.apiURL + Config.activate;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString("accessToken");
    try {
      var response = await dio.post(activateURL,
          data: {'username': username, 'password': password, 'userId': userId},
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(String phone, String password) async {
    bool isLogin = false;
    try {
      var url = Config.apiURL + Config.login;
      var response = await Dio().post(
        url,
        data: {"phone": phone, "password": password},
      );
      var accessToken = response.data['accessToken'];
      var userData = response.data['user'];
      if (response.statusCode == 200) {
        sharedPref().setAuthToken(accessToken);
        sharedPref().setUserDetails(userData);
        isLogin = true;
      }
    } catch (e) {
      print(e);
    }

    return isLogin;
  }

  // update user profile
  static Future<bool> updateProfile(String id, String fname, String lname,
      String secEmail, String state, String district, String profile) async {
    bool isUpdate = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      var url = Config.apiURL + Config.update_profile;
      var response = await Dio().post(url,
          data: {
            'id': id,
            "fname": fname,
            "lname": lname,
            "secondaryEmail": secEmail,
            "state": state,
            "city": district,
            "profile": profile,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        isUpdate = true;
      }
    } catch (e) {
      print(e);
    }

    return isUpdate;
  }

  // change password
  static Future<bool> changePassword(
      id, String oldPassword, String newPassword) async {
    bool isChange = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = Config.apiURL + Config.changePassword;
      var response = await Dio().post(url, data: {
        'id': id,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      });

      if (response.statusCode == 200) {
        isChange = true;
      }
    } catch (e) {
      print(e);
    }

    return isChange;
  }

  // get user profile with id from url
  Future<OtherUserResp?> getUserProfile(String id) async {
    OtherUserResp? otherUserResp;
    var jsonResp;
    try {
      var url = Config.apiURL + '${Config.getUser}/$id';
      Response response = await Dio().get(url);
      otherUserResp = OtherUserResp.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return otherUserResp;
  }

  // search user by username
  Future searchUser(String? username) async {
    try {
      var url = Config.apiURL + Config.searchUser;

      var dio = Dio();
      Response response = await dio.post(
        url,
        data: {"username": username},
      );
      if (response.statusCode == 201) {
        return response.data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // follow user
  static Future<bool> followUser(id) async {
    bool isFollow = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var userId = prefs.getString("id");

    try {
      var url = Config.apiURL + Config.follow;
      var response = await Dio().put(url,
          data: {'userId': userId, 'followId': id},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        isFollow = true;
      }
    } catch (e) {
      print(e);
    }
    return isFollow;
  }
}
