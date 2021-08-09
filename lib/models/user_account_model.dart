import 'package:scoped_model/scoped_model.dart';  //this used to pass the data from base class which is here Model class to the child class which is here UserAccountModel class
import 'package:shared_preferences/shared_preferences.dart'; //this used to save the data on the user device

class UserAccountModel extends Model {
  bool isLoggedIn = false;
  String userToken;
  String userName;
  String userType;
  String userPhone;
  String userEmail;
  String userPhoto;
  String userAddress;
  // this will check if the user account details is at the user device
  Future<dynamic> fetchUserAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isToken = prefs.containsKey("api_token"); //this will return true if the api_token in the device
    if (isToken) {
      isLoggedIn = true;
      userToken = prefs.getString("api_token");
      userName = prefs.getString("userName");
      userType = prefs.getString("userType");
      userPhone = prefs.getString("userPhone");
      userEmail = prefs.getString("userEmail");
      userPhoto = prefs.getString("userPhoto");
      userAddress = prefs.getString("userAddress");
    } else {
      isLoggedIn = false;
      userToken = null;
      userName = null;
      userPhone = null;
      userType = null;
      userEmail = null;
      userPhoto = null;
      userAddress = null;
    }

    notifyListeners();
  }
  //this will make set to the user details
  Future<dynamic> fetchUserLogin(
      {String token,
      String name,
      String type,
      String phone,
      String email,
      String address,
      String photo}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("api_token", token);
    prefs.setString("userName", name);
    prefs.setString("userPhone", phone);
    prefs.setString("userType", type);
    prefs.setString("userEmail", email);
    prefs.setString("userPhoto", photo);
    prefs.setString("userAddress", address);

    await fetchUserAccount();
  }

  // this method will remove the details from user device when user make logout from the app
  Future<dynamic> fetchUserLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("api_token");
    prefs.remove("userName");
    prefs.remove("userPhone");
    prefs.remove("userType");
    prefs.remove("userEmail");
    prefs.remove("userPhoto");
    prefs.remove("userAddress");

    await fetchUserAccount();
  }
}
