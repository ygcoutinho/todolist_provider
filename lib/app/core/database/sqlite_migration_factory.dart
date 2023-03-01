import 'package:todolist_provider/app/core/database/migrations/migration.dart';
import 'package:todolist_provider/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
        MigrationV1(),
      ];

  List<Migration> getUpgradeMigration(int oldVersion) => [];
}
