import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/user_manager/user_manager.dart';

class UserViewModel extends StateNotifier<User?>{
  UserViewModel(super.state){
    refressUser();
  }

  Future<void> refressUser() async {
    state = await UserManager.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    await UserManager.login(email, password);
    refressUser();
  }

  Future<void> logout() async {
    await UserManager.logout();
    refressUser();
  }

  Future<void> register(String name, String email, String password) async {
    await UserManager.register(name, email, password);
    refressUser();
  }
}