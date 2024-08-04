enum ColumnType {
  integer,
  dateTime,
  real,
  text,
  blob,
}

extension ColumeTypeExt on ColumnType {
  String stringtify() {
    switch (this) {
      case ColumnType.integer:
        return 'INTEGER';
      case ColumnType.dateTime:
      case ColumnType.text:
        return 'TEXT';
      case ColumnType.real:
        return 'REAL';
      case ColumnType.blob:
        return 'BLOB';
      default:
        return '';
    }
  }
}

abstract class ColumnBuilder {
  ColumnBuilder setColumn({
    String? name,
    ColumnType? type,
    bool? isPrimary,
    bool? autoIncrement,
  });

  String build();
}

abstract class JoinBuilder {
  
}

abstract class WhereBuilder {
  
}
