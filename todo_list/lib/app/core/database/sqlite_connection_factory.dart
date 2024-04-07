
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;

  Database? _db; // classe que controla meu banco de dados | verifica se está aberto ou não
  final _lock = Lock(); // é para trabalharmos com multi threads. | temos concorrencia de chamadas nos métodos;
                       
  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    // essa classe verifica se já existe a instancia
    // se não tiver a instancia ele cria e retorna
    if(_instance == null) {
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    // essa lib path nos fornece o método join que pega e cria o nome do arquivo independente do device do usuário.
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      // O processo de sincronizar é aguardar o processo acontecer. No caso o processo de conexão com DB
    await _lock.synchronized(() async {
      if (_db == null) {
        // criando conexão com banco
       _db = await openDatabase(
       databasePathFinal,
       version: _VERSION,
       onConfigure: _onConfigure,
       onCreate: _onCreate,
       onUpgrade: _onUpgrade,
       onDowngrade: _onDowngrade
      );  
      }
    });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreing_keys=ON');
  }
  Future<void> _onCreate(Database db, int version) async {}
  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {}
  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}

}