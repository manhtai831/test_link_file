import 'package:live_data_test/column_builder.dart';
import 'package:live_data_test/query_model.dart';

class TableBuilder implements ColumnBuilder {
  final buffer = StringBuffer();
  final List<StringBuffer> columns = [];

  ColumnBuilder createTable({String? name}) {
    buffer
      ..write('CREATE TABLE IF NOT EXIST $name')
      ..write(' (');
    return this;
  }

  @override
  ColumnBuilder setColumn({
    String? name,
    ColumnType? type,
    bool? isPrimary,
    bool? autoIncrement,
  }) {
 
    
    columns.add(sb);
    return this;
  }

  @override
  String build() {
       final sb = StringBuffer();
    sb
      ..write(name)
      ..write(' ')
      ..write(type?.stringtify());
    if (isPrimary == true) {
      sb
        ..write(' ')
        ..write('PRIMARY KEY');
    }
    if (autoIncrement == true && type == ColumnType.integer) {
      sb
        ..write(' ')
        ..write('AUTOINCREMENT');
    }

    buffer
      ..write(columns.join(', '))
      ..write(')');
    return buffer.toString();
  }
}

abstract class QueryBuilder {
  QueryBuilder join({
    String? tableName,
    String? alias,
    String? on,
  });
  QueryBuilder select({
    Iterable<String>? selects,
  });

  QueryBuilder where({
    String? where,
    String? groupBy,
    String? orderBy,
    String? having,
  });
  QueryBuilder createBuilder({
    String? tableName,
    String? alias,
    int? limit,
    int? offset,
  });

  String build();
}

class QueryBuilderImpl implements QueryBuilder {
  final QueryModel _query = QueryModel();

  @override
  QueryBuilder createBuilder({
    String? tableName,
    String? alias,
    int? limit,
    int? offset,
  }) {
    _query
      ..mainTable = TableQueryModel(tableName: tableName, alias: alias)
      ..limit = limit
      ..offset = offset;

    return this;
  }

  @override
  String build() {
    final buffer = StringBuffer();
    buffer
      ..write('SELECT')
      ..write(' ');
    if (_query.selects != null && _query.selects!.isNotEmpty) {
      buffer.writeAll(_query.selects!, ', ');
    } else {
      buffer.write('*');
    }
    buffer
      ..write(' ')
      ..write('FROM')
      ..write(' ')
      ..write(_query.mainTable?.tableName);
    if (_query.mainTable?.alias != null) {
      buffer
        ..write(' ')
        ..write('AS')
        ..write(' ')
        ..write(_query.mainTable?.alias);
    }

    if (_query.joinTables != null && _query.joinTables!.isNotEmpty) {
      buffer
        ..write(' ')
        ..writeAll(
          _query.joinTables!.map((e) => 'JOIN ${e.tableName} as ${e.alias} on ${e.on}'),
          ' ',
        );
    }
    if (_query.where != null) {
      buffer
        ..write(' ')
        ..write('WHERE')
        ..write(' ')
        ..write(_query.where);
    }
    if (_query.groupBy != null) {
      buffer
        ..write(' ')
        ..write('GROUP BY')
        ..write(' ')
        ..write(_query.groupBy);
    }
    if (_query.having != null) {
      buffer
        ..write(' ')
        ..write('HAVING')
        ..write(' ')
        ..write(_query.having);
    }
    if (_query.orderBy != null) {
      buffer
        ..write(' ')
        ..write('ORDER BY')
        ..write(' ')
        ..write(_query.orderBy);
    }
    if (_query.limit != null) {
      buffer
        ..write(' ')
        ..write('LIMIT')
        ..write(' ')
        ..write(_query.limit);
    }
    if (_query.offset != null) {
      buffer
        ..write(' ')
        ..write('OFFSET')
        ..write(' ')
        ..write(_query.offset);
    }

    return buffer.toString();
  }

  @override
  QueryBuilder join({String? tableName, String? alias, String? on}) {
    _query.joinTables ??= [];
    _query.joinTables?.add(TableQueryModel(tableName: tableName, alias: alias, on: on));
    return this;
  }

  @override
  QueryBuilder select({Iterable<String>? selects}) {
    if (selects != null) {
      _query.selects ??= [];
      _query.selects?.addAll(selects);
    }

    return this;
  }

  @override
  QueryBuilder where({String? where, String? groupBy, String? orderBy, String? having}) {
    _query
      ..where = where
      ..groupBy = groupBy
      ..orderBy = orderBy
      ..having = having;
    return this;
  }
}
