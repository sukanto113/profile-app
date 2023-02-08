import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/user.dart';

class AuthNotifire extends StateNotifier<User?>{
  final UserRepository userRepository;

  AuthNotifire(super.state, this.userRepository){
    refressUser();
  }

  Future<void> refressUser() async {
    state = await userRepository.getCurrentUser();
  }

  Future<bool> login(String email, String password) async {
    bool isSuccess = await userRepository.login(email, password);
    refressUser();
    return isSuccess;
  }

  Future<void> logout() async {
    await userRepository.logout();
    refressUser();
  }

  Future<bool> register(String name, String email, String password) async {
    bool isSuccess = await userRepository.register(name, email, password);
    refressUser();
    return isSuccess;
  }
}