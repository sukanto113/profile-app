import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/auth/authenticator.dart';
import 'package:profile_app/db/sqflite_student_database.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/appstate.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/notifiers/student_list_notifire.dart';
import 'package:profile_app/notifiers/auth_notifier.dart';

final Provider<IStudentRepository> studentRepositoryProvider =
    Provider<IStudentRepository>((_) {
  return SqfliteStudentsRepository.instance;
});

final FutureProvider<Iterable<Student>> studentsListProvider =
    FutureProvider<Iterable<Student>>((ref) async {
  ref.watch(studentsListNotifireProvider);
  final repo = ref.read(studentRepositoryProvider);
  return repo.readAll();
});

final StateNotifierProvider<StudentsListNotifire, int>
    studentsListNotifireProvider =
    StateNotifierProvider<StudentsListNotifire, int>((ref) {
  final repo = ref.read(studentRepositoryProvider);
  return StudentsListNotifire(0, repo);
});

final userRepoProvider = Provider<IUserRepository>((_) {
  return UserRepositoryLocal(AuthenticatorLocal());
});

final userProvider = FutureProvider<User?>((ref) async {
  ref.watch(authNotifireProvider);

  return ref.read(userRepoProvider).getCurrentUser();
});

final authNotifireProvider = StateNotifierProvider<AuthNotifire, int>((ref) {
  final reop = ref.read(userRepoProvider);
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

final loadingProvider = StateProvider<bool>((_) => false);
