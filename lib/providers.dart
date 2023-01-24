import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/user_manager/user_manager.dart';
import 'package:profile_app/view_model/student_list.dart';
import 'package:profile_app/view_model/user.dart';


final studentsListProvider = 
  StateNotifierProvider<StudentsListViewModel, StudentsListState>(
    (ref) => StudentsListViewModel(StudentsDatabase.instance, StudentsListState([]))
  );

final userProvider = StateNotifierProvider<UserViewModel, User>((ref)=> UserViewModel(const User(name: "", email: "")));

// final userProvider = FutureProvider<User>((ref) async {
//   return  await ref.watch(userManagerProvider);
// });
