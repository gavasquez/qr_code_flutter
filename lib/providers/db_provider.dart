import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  // instancia de la clase
  static final DBProvider db = DBProvider._();
  /* Constructor privado */
  DBProvider._();

  Future<Database> get database async {
    // Si existe la base de datos que me retorne la base de datos
    if (_database != null) return _database!;
    // si no esta instanciada la base de datos que cree una nueva instancia
    _database = await initDB();
    return _database!;
  }

  // metodo para inicializar la base de datos
  Future<Database> initDB() async {
    // path de donde almacenaremos la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // join sirve para unir pedazos de path
    final path = join(documentDirectory.path, 'ScansDB.db');
    print(path);
    // crear base de datos
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    });
  }
}
