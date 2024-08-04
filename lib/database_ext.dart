import 'package:sqflite/sqflite.dart';

extension DatabaseExt on Database {
  Future<List<Map<String, Object?>>> getAllTable() {
    return query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
  }

  Future<int?> getCount({String? tableName}) async {
    return Sqflite.firstIntValue(
      await rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
  }

  Future<String?> getSqlVersion() async {
    return (await rawQuery('SELECT sqlite_version()')).first.values.first.toString();
  }
}
