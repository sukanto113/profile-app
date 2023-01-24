import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/user_manager/user_manager.dart';

class UserViewModel extends StateNotifier<User>{
  // final User
  UserViewModel(super.state){
    _refressUser();
  }

  // logIn
  // logOut
  // register

  Future<void> _refressUser() async {
    state = await UserManager.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    await UserManager.login(email, password);
    _refressUser();
  }

  Future<void> logout() async {
    await UserManager.logout();
    _refressUser();
  }

  Future<void> register(String name, String email, String password) async {
    await UserManager.register(name, email, password);
    _refressUser();
  }
}