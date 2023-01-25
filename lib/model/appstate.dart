import 'package:profile_app/user_manager/user_manager.dart';

class AppState{
  const AppState({this.user});
  final User? user;

  AppState copyWith({User? newUser}){
    return AppState(
      user: newUser ?? user
    );
  }
}