import 'package:profile_app/model/user.dart';

class AppState{
  const AppState({this.user});
  final User? user;

  AppState copyWith({User? newUser}){
    return AppState(
      user: newUser ?? user
    );
  }
}
