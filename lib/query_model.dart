class QueryModel {
  TableQueryModel? mainTable;
  List<TableQueryModel>? joinTables = [];
  int? limit;
  int? offset;
  List<String>? selects = [];
  String? groupBy;
  String? having;
  String? where;
  String? orderBy;

  QueryModel({
    this.mainTable,
    this.joinTables,
    this.limit,
    this.offset,
    this.groupBy,
    this.selects,
    this.having,
    this.where,
    this.orderBy,
  });
}

class TableQueryModel {
  String? tableName;
  String? alias;
  String? on;
  TableQueryModel({
    this.tableName,
    this.alias,
    this.on,
  });
}
