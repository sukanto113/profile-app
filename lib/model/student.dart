class StudentState{
  
  final int id;
  final String name;
  final String roll;

  const StudentState({
    required this.id,
    required this.name,
    required this.roll
  });

  StudentState copyWith({String? name, String? roll}){
    return StudentState(
      id: id,
      name: name ?? this.name,
      roll: roll ?? this.roll,
    );
  }
}

class StudentsListState{
  final Iterable<StudentState> students;
  StudentsListState(Iterable<StudentState> students):students = List.unmodifiable(students);
}