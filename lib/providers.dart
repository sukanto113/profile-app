import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  (ref)=> UserManager(null, const UserRepositoryLocal())
);

final initialAppStateProvider = FutureProvider<AppState>((ref) async {
  await ref.read(userProvider.notifier).refressUser();
  return AppState(user: ref.read(userProvider));
});
