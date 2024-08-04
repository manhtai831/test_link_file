import 'dart:async';

import 'package:live_data_test/column_builder.dart';
import 'package:live_data_test/query_builder.dart';

void main(List<String> arguments) {
  final data = DateTime.now().toUtc().toIso8601String();
  print('[VERBOSE]  ${DateTime.now()}  LiveDataTest   ${data}');
  print('[VERBOSE]  ${DateTime.now()}  LiveDataTest   ${DateTime.parse(data).toLocal()}');
  // final database = openDatabase(
  //   'test.db',
  //   version: 1,
  //   onCreate: _onCreate,
  //   onUpgrade: _onUpgrade,
  //   onDowngrade: _onDowngrage,
  // );
  final builder = TableBuilder()
      .createTable(name: 'CC')
      .setColumn(
        name: 'id',
        type: ColumnType.integer,
        autoIncrement: true,
        isPrimary: true,
      )
      .setColumn(name: 'name', type: ColumnType.text)
      .setColumn(name: 'age', type: ColumnType.integer);
  final query = QueryBuilderImpl()
      .createBuilder(tableName: 'student', alias: 's', limit: 10, offset: 0)
      // .join(tableName: 'class', alias: 'c', on: 'c.id = s.class_id')
      // .join(tableName: 'teacher', alias: 't', on: 't.id = s.t_id')
      .select(selects: ['asdf', '123123']).where(where: 'name = 1231');
  print('[VERBOSE]  ${DateTime.now()}  LiveDataTest   ${query.build()}');
}
