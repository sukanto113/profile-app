import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/user_reopsitory.dart';

class AuthNotifire extends StateNotifier<int>{
  final UserRepository userRepository;

  AuthNotifire(super.state, this.userRepository);


  Future<bool> login(String email, String password) async {
    bool isSuccess = await userRepository.login(email, password);
    state++;
    return isSuccess;
  }

  Future<void> logout() async {
    await userRepository.logout();
    state++;
  }

  Future<bool> register(String name, String email, String password) async {
    bool isSuccess = await userRepository.register(name, email, password);
    return isSuccess;
  }
}