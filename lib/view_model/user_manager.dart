import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/user.dart';

class UserManager extends StateNotifier<User?>{
  UserManager(super.state){
    refressUser();
  }

  Future<void> refressUser() async {
    state = await UserRepositoryLocal.getCurrentUser();
  }

  Future<bool> login(String email, String password) async {
    bool isSuccess = await UserRepositoryLocal.login(email, password);
    refressUser();
    return isSuccess;
  }

  Future<void> logout() async {
    await UserRepositoryLocal.logout();
    refressUser();
  }

  Future<bool> register(String name, String email, String password) async {
    bool isSuccess = await UserRepositoryLocal.register(name, email, password);
    refressUser();
    return isSuccess;
  }
}