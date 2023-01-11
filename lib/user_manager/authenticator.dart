import 'package:shared_preferences/shared_preferences.dart';

class Authenticator{
  static Future<String?> authenticate(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final authPassword = prefs.getString('user/$email/password');
    if(authPassword !=null){
      if(password == authPassword){
        final name = prefs.getString('user/$email/name');
        return name;
      }
      return null;
    }else{
      return null;
    }
  }

  static Future<bool> addUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user/$email/password', password);
    await prefs.setString('user/$email/name', name);
    return true;
  }
}