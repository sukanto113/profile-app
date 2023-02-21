import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void setupSqfliteTestEnv() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

Future<Iterable<String>> queryColumnsName(Database db, String tableName) async {
  var result = await db.query(
    'sqlite_schema',
    columns: ['sql'],
    where: 'tbl_name = ?',
    whereArgs: [tableName]
  );
  if(result.isEmpty){
    throw Exception("No such table name $tableName");
  }
  var sql = result[0]["sql"].toString();
  return RegExp(r'(^  \w+)', multiLine: true).allMatches(sql).map((match) { 
    return (sql.substring(match.start, match.end)).trim();
  });
}