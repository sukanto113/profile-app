class Student{
  
  final int id;
  final String name;
  final String roll;

  const Student({
    required this.id,
    required this.name,
    required this.roll
  });

  @override
  bool operator == (Object other) =>
    other is Student &&
    other.id == id &&
    other.name == name &&
    other.roll == roll;

  Student copyWith({String? name, String? roll}){
    return Student(
      id: id,
      name: name ?? this.name,
      roll: roll ?? this.roll,
    );
  }
  
  @override
  int get hashCode => Object.hash(id, name, roll);

  @override
  String toString() {
    return "{ id: $id, name: $name, roll: $roll }";
  }
}

class StudentsListState{
  final Iterable<Student> students;
  StudentsListState(Iterable<Student> students):students = List.unmodifiable(students);
}