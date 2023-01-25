import 'package:shared_preferences/shared_preferences.dart';

abstract class Authenticator {
  Future<bool> authenticate(String email, String password);
  Future<UserInfo> getUserInfo(String email, String password);
  Future<bool> addUser(String name, String email, String password);
}

class AuthenticatorLocal implements Authenticator {
  @override
  Future<bool> authenticate(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final authPassword = prefs.getString('user/$email/password');
    if(authPassword == password){
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<UserInfo> getUserInfo(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if(await authenticate(email, password)){
      String userName = prefs.getString('user/$email/name') ?? "";
      return UserInfo(email: email, userName: userName);
    }else{
      return const UserInfo(email: "", userName: "");
    }
  }

  @override
  Future<bool> addUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user/$email/password', password);
    await prefs.setString('user/$email/name', name);
    return true;
  }
}

class UserInfo{

  final String email;
  final String userName;

  const UserInfo({required this.email, required this.userName});
}