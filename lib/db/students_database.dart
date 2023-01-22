import 'package:profile_app/model/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

const studentsTable = 'students';

class StudentFields{
  static const id = '_id';
  static const name = 'name';
  static const roll = 'roll';
  
  static toList() {
    return [
      StudentFields.id,
      StudentFields.name,
      StudentFields.roll
    ];
  }

  static StudentState convertMapToStudent(Map<String, Object?> record) {
    return StudentState(
      id: record[StudentFields.id] as int,
      name: record[StudentFields.name] as String,
      roll: record[StudentFields.roll] as String,
    );
  }

  static Map<String, Object?> convertToMap({
    required String name, required String roll
    }) {
    return {
      StudentFields.name: name,
      StudentFields.roll: roll 
    };
  }

  static Map<String, Object?> convertStudentToMap(StudentState student){
    return convertToMap(name: student.name, roll: student.roll);
  }

}

class StudentsDatabase implements StudentRepository{
  static final StudentsDatabase instance = StudentsDatabase._init();

  static Database? _database;

  StudentsDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('notes.db');

    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $studentsTable(
  ${StudentFields.id} $idType,
  ${StudentFields.name} $textType,
  ${StudentFields.roll} $textType
)
''');
  }

  @override
  Future<StudentState> create({
    required String name,
    required String roll,
    }) async{
    
    final db = await instance.database;

    final id = await db.insert(studentsTable, StudentFields.convertToMap(
      name: name, roll: roll
    ));

    return StudentState(id: id, name: name, roll: roll);
  }

  @override
  Future<StudentState> read(int id) async {
    final db = await instance.database;

    final result = await db.query(
      studentsTable,
      columns: StudentFields.toList(),
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );

    if(result.isNotEmpty){
      return StudentFields.convertMapToStudent(result.first);
    }else{
      throw Exception('Id $id not found');
    }
  }

  @override
  Future<List<StudentState>> readAll() async {
    final db = await instance.database;

    final result = await db.query(
      studentsTable,
      orderBy: '${StudentFields.id} ASC'
    );

    return _convertMapsToStudents(result);
  }

  @override
  Future<int> update(StudentState student) async {
    final db = await instance.database;
    return await db.update(
      studentsTable,
      StudentFields.convertStudentToMap(student),
      where: '${StudentFields.id} = ?',
      whereArgs: [student.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      studentsTable,
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  List<StudentState> _convertMapsToStudents(List<Map<String, Object?>> result) {
    return result.map(
      (record) => StudentFields.convertMapToStudent(record)
    ).toList();
  }
}

abstract class StudentRepository{
  Future<StudentState> create({
    required String name,
    required String roll,
    });
  Future<StudentState> read(int id);
  Future<Iterable<StudentState>> readAll();
  Future<int> update(StudentState student);
  Future<int> delete(int id);
  Future<void> close();

}

class InMemoryStudentRepo extends StudentRepository {
  
  List<StudentState> students = [];
  int nextIndex = 1;
  
  @override
  Future<void> close() async {
  }

  @override
  Future<StudentState> create({required String name, required String roll}) async {
    var student = StudentState(id: nextIndex++, name: "", roll: "");
    students.add(student);
    return student;
  }

  @override
  Future<int> delete(int id) async {
    final student = await read(id); 
    students.remove(student);
    return 1;
  }

  @override
  Future<StudentState> read(int id) async {
    for(final student in students){
      if(student.id == id) return student;
    }
    throw Exception("id not found");
  }

  @override
  Future<Iterable<StudentState>> readAll() async {
    return students;
  }

  @override
  Future<int> update(StudentState student) async {
    var index = _getIndex(student);
    students[index] = student;
    return index;
  }

  int _getIndex(StudentState student){
    for(var i = 0; i < students.length; ++i){
      if(student.id == students[i].id) return i;
    }
    throw Exception("id not found");
  }
}
