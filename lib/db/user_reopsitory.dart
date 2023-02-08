import 'package:profile_app/auth/authenticator.dart';
import 'package:profile_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository{
  Future<User?> getCurrentUser();
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<bool> register(String name, String email, String password);
}

class UserRepositoryLocal implements UserRepository{
  static const currentUserEmailSharedPrefKey= 'currentUser/email';
  static const currentUserNameSharedPrefKey= 'currentUser/name';
  static const hasCurrentUserSharedPrefKey = 'hasUser';
  final Authenticator authenticator;

  const UserRepositoryLocal(this.authenticator);

  Future<bool> hasUser() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasUserValue = prefs.getBool(hasCurrentUserSharedPrefKey) ?? false;    
    return hasUserValue;
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 3));
    if(await hasUser()){
      final prefs = await SharedPreferences.getInstance();
      final String userName = prefs.getString(currentUserNameSharedPrefKey) ?? "";    
      final String userEmail = prefs.getString(currentUserEmailSharedPrefKey) ?? "";  
      return User(name: userName, email: userEmail);
    }else{
      return null;
    }
  }

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    bool isAuthenticate = await authenticator.authenticate(email, password);
    if(isAuthenticate){
      final UserInfo userInfo = await authenticator.getUserInfo(email, password);
      await _saveCurrentUser(User(name: userInfo.userName, email: email));
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(hasCurrentUserSharedPrefKey, false);
    prefs.remove(currentUserNameSharedPrefKey);
    prefs.remove(currentUserEmailSharedPrefKey);
  }

  @override
  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    final bool isSuccessfull = await authenticator.addUser(name, email, password);
    return isSuccessfull;
  }

  Future<void> _saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(hasCurrentUserSharedPrefKey, true);
    await prefs.setString(currentUserEmailSharedPrefKey, user.email);
    await prefs.setString(currentUserNameSharedPrefKey, user.name);
  }
}
