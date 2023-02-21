
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

const studentsTable = 'students';
const databaseFileName = 'notes.db';

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

  static Student convertMapToStudent(Map<String, Object?> record) {
    return Student(
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

  static Map<String, Object?> convertStudentToMap(Student student){
    return convertToMap(name: student.name, roll: student.roll);
  }

}

class SqfliteStudentsRepository implements IStudentRepository{

  Database? _database;

  static Future<String> getDatabaseFilePath() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, databaseFileName);
    return path;
  }

  Future<Database> get database async {
    if(_database != null) return _database!;
    
    final path = await getDatabaseFilePath();
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
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
  Future<Student> create({
    required String name,
    required String roll,
  }) async {
      

    final id = await (await database).insert(studentsTable, StudentFields.convertToMap(
      name: name, roll: roll
    ));

    return Student(id: id, name: name, roll: roll);
  }

  @override
  Future<Student> read(int id) async {

    final result = await (await database).query(
      studentsTable,
      columns: StudentFields.toList(),
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );

    if(result.isNotEmpty){
      return StudentFields.convertMapToStudent(result.first);
    }else{
      throw ArgumentError('Id $id not found');
    }
  }

  @override
  Future<List<Student>> readAll() async {
    final result = await (await database).query(
      studentsTable,
      orderBy: '${StudentFields.id} ASC'
    );

    return _convertMapsToStudents(result);
  }

  @override
  Future<int> update(Student student) async {
    return await (await database).update(
      studentsTable,
      StudentFields.convertStudentToMap(student),
      where: '${StudentFields.id} = ?',
      whereArgs: [student.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await (await database).delete(
      studentsTable,
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    (await database).close();
  }

  List<Student> _convertMapsToStudents(List<Map<String, Object?>> result) {
    return result.map(
      (record) => StudentFields.convertMapToStudent(record)
    ).toList();
  }
}
