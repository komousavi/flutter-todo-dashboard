import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  IntColumn get color => integer()();

  IntColumn get iconCodePoint => integer()();

  TextColumn get iconFontFamily => text()();

  TextColumn get iconFontPackage => text().nullable()();
}