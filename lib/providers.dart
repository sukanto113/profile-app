import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/view_model/student_list.dart';


final studentsListProvider = 
  StateNotifierProvider<StudentsListViewModel, StudentsListState>(
    (ref) => StudentsListViewModel(StudentsDatabase.instance ,StudentsListState([]))
  );
