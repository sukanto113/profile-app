import 'package:profile_app/user_manager/authenticator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager{
  static const currentUserEmailSharedPrefKey= 'currentUser/email';
  static const currentUserNameSharedPrefKey= 'currentUser/name';

  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString(currentUserNameSharedPrefKey);    
    final String? userEmail = prefs.getString(currentUserEmailSharedPrefKey);  

    if(userName != null && userEmail != null ){
      return User(name: userName, email: userEmail);
    }else{
      return null;
    }
  }

  static Future<User?> login(String email, String password) async {
    final userName = await Authenticator.authenticate(email, password);
    if(userName != null){
      User user = User(name: userName, email: email);
      await _saveCurrentUser(user);
      return user;
    }else{
      return null;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
    bool isSuccessfull = await Authenticator.addUser(name, email, password);
    return isSuccessfull;
  }

  static Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(currentUserEmailSharedPrefKey, user.email);
    await prefs.setString(currentUserNameSharedPrefKey, user.name);
  }
}

class User{
  const User({required this.name, required this.email});
  final String name;
  final String email;
}