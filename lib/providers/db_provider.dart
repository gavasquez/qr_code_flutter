import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_code/models/scan_model.dart';
export 'package:qr_code/models/scan_model.dart';

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

  // Agregar datos a la base de datos
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    // Esperamos hasta que la base de datos este lista, verificamos
    final db = await database;
    // query de insertar
    final res = await db.rawInsert('''
        INSERT INTO Scans(id, tipo, valor) 
        VALUES ($id, '$tipo', '$valor')
      ''');
    return res;
  }

  // Crear Scans
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    // El res el id del dato insertado
    return res;
  }

  // obtener scans por id
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // obtener todos los scans
  Future<List<ScanModel>?> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  // Obtener Scanas by Tipo
  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans where tipo ='$tipo'
    ''');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  // Acualizar un Scans by Id
  Future<int> updateScans(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // borrar Scans
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // borrar todos los scans
  Future<int> deleteScanAll() async {
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM Scans
      ''');
    return res;
  }
}
