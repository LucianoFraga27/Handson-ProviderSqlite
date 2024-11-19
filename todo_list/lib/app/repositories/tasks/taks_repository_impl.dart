import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list/app/repositories/tasks/taks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({required SqliteConnectionFactory sqlLiteConnection})
      : _sqliteConnectionFactory = sqlLiteConnection;

  @override
  Future<void> save(DateTime data, String description) async {
    final connection = await _sqliteConnectionFactory.openConnection();
    await connection.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': data.toIso8601String(),
      'finalizado': 0
    });
  }
}
