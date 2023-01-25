import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/auth/authenticator.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/db/user_reopsitory.dart';
import 'package:profile_app/model/appstate.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/view_model/student_list.dart';
import 'package:profile_app/view_model/user_manager.dart';


final studentsListProvider = 
  StateNotifierProvider<StudentsListViewModel, StudentsListState>(
    (ref) => StudentsListViewModel(StudentsDatabase.instance, StudentsListState([]))
  );

final userProvider = StateNotifierProvider<UserManager, User?>(
  (ref)=> UserManager(null, UserRepositoryLocal(AuthenticatorLocal()))
);

final initialAppStateProvider = FutureProvider<AppState>((ref) async {
  await ref.read(userProvider.notifier).refressUser();
  return AppState(user: ref.read(userProvider));
});

final userImageProvider = Provider<ImageProvider>((ref) {
  return const AssetImage("images/sukanto_profile_pic.jpg");
});

final userBioProvider = Provider<String>((ref) {
  return "Hi, I'm Sukanto Saha, I'm M.Sc. student of Rajshahi "
    "University. I completed my graduation in "
    "Mathematics from Rajshahi University.";
});