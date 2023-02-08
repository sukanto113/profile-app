import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/auth/authenticator.dart';
import 'package:profile_app/db/sqflite_student_database.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/appstate.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/notifiers/student_list.dart';
import 'package:profile_app/notifiers/auth_notifier.dart';


final studentRepositoryProvider = Provider<IStudentRepository>((_){
  return SqfliteStudentsRepository.instance;
});

final studentsListProvider = FutureProvider<Iterable<Student>>((ref) async {
  final repo = ref.watch(studentRepositoryProvider);
  ref.watch(studentsListNotifireProvider);
  return await repo.readAll();
});

final studentsListNotifireProvider = StateNotifierProvider<StudentsListNotifire, int>((ref) {
  final repo = ref.watch(studentRepositoryProvider);
  return StudentsListNotifire(0, repo);
});

final userRepoProvider = Provider<IUserRepository>((_){
  return UserRepositoryLocal(AuthenticatorLocal());
});

final userProvider = FutureProvider<User?>((ref) async {
  ref.watch(authNotifireProvider);

  return await ref.read(userRepoProvider).getCurrentUser();
});

final authNotifireProvider = StateNotifierProvider<AuthNotifire, int>((ref) {
  final reop = ref.watch(userRepoProvider);
  return AuthNotifire(0, reop);
});

final initialAppStateProvider = FutureProvider<AppState>((ref) async {
  final User? user = await ref.read(userRepoProvider).getCurrentUser();
  return AppState(user: user);
});

final userImageProvider = Provider<ImageProvider>((ref) {
  return const AssetImage("images/sukanto_profile_pic.jpg");
});

final userBioProvider = Provider<String>((ref) {
  return "Hi, I'm Sukanto Saha, I'm M.Sc. student of Rajshahi "
    "University. I completed my graduation in "
    "Mathematics from Rajshahi University.";
});

final loadingProvider = StateProvider<bool>((_)=>false);
