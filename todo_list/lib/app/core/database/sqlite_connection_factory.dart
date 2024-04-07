
class SqliteConnectionFactory {
  
  static SqliteConnectionFactory? _instance;

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    // essa classe verifica se já existe a instancia
    // se não tiver a instancia ele cria e retorna
    if(_instance == null) {
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }

}