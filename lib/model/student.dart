class Student{
  
  final int id;
  final String name;
  final String roll;

  const Student({
    required this.id,
    required this.name,
    required this.roll
  });

  Student copyWith({String? name, String? roll}){
    return Student(
      id: id,
      name: name ?? this.name,
      roll: roll ?? this.roll,
    );
  }
}

class StudentsListState{
  final Iterable<Student> students;
  StudentsListState(Iterable<Student> students):students = List.unmodifiable(students);
}