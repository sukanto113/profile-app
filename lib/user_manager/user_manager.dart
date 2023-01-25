import 'package:profile_app/user_manager/authenticator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager{
  static const currentUserEmailSharedPrefKey= 'currentUser/email';
  static const currentUserNameSharedPrefKey= 'currentUser/name';
  static const hasCurrentUserSharedPrefKey = 'hasUser';

  static Future<bool> hasUser() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasUserValue = prefs.getBool(hasCurrentUserSharedPrefKey) ?? false;    
    return hasUserValue;
  }

  static Future<User> getCurrentUser() async {

    if(await hasUser()){
      final prefs = await SharedPreferences.getInstance();
      final String userName = prefs.getString(currentUserNameSharedPrefKey) ?? "";    
      final String userEmail = prefs.getString(currentUserEmailSharedPrefKey) ?? "";  
      return User(name: userName, email: userEmail);
    }else{
      return const User(name: "", email: "");
    }
  }

  static Future<bool> login(String email, String password) async {
    bool isAuthenticate = await Authenticator.authenticate(email, password);
    if(isAuthenticate){
      final UserInfo userInfo = await Authenticator.getUserInfo(email, password);
      await _saveCurrentUser(User(name: userInfo.userName, email: email));
      return true;
    }else{
      return false;
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(hasCurrentUserSharedPrefKey, false);
    prefs.remove(currentUserNameSharedPrefKey);
    prefs.remove(currentUserEmailSharedPrefKey);
  }

  static Future<bool> register(String name, String email, String password) async {
    final bool isSuccessfull = await Authenticator.addUser(name, email, password);
    return isSuccessfull;
  }

  static Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hasCurrentUserSharedPrefKey, true);
    await prefs.setString(currentUserEmailSharedPrefKey, user.email);
    await prefs.setString(currentUserNameSharedPrefKey, user.name);
  }
}

class User{
  const User({required this.name, required this.email});
  final String name;
  final String email;
  static const User emptyUser = User(name: "", email: "");
}