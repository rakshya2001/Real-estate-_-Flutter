import 'package:shared_preferences/shared_preferences.dart';

class sharedPref {
  //set > local storage
  setAuthToken(String accessToken) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString("token", accessToken);
  }

  //get > local storage
  getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  //remove > local storage
  Future<bool> removeAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove("token");
  }

  // set all user details in local storage from login response
  setUserDetails(var user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", user['id']);
    prefs.setString("profile", user['profile']);
    prefs.setString("username", user['username']);
    prefs.setString("fname", user['fname']);
    prefs.setString("lname", user['lname']);
    prefs.setString("secemail", user['secondaryEmail']);
    prefs.setString("state", user['address']['state']);
    prefs.setString("district", user['address']['state']);
    // followers
    prefs.setString("followers", user['followers']);
    prefs.setString("following", user['following']);
  }

  // get id of the user
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id");
  }

  // get user details from local storage
  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return id, username, fname
    return {
      'id': prefs.getString("id"),
      'username': prefs.getString("username"),
      'fname': prefs.getString("fname"),
      'lname': prefs.getString("lname"),
      'secemail': prefs.getString("secemail"),
      'state': prefs.getString("state"),
      'district': prefs.getString("district"),
      'profile': prefs.getString("profile"),
      'followers': prefs.getString("followers"),
      'following': prefs.getString("following"),
    };
  }
}

enum UserPref {
  accessToken,
}
