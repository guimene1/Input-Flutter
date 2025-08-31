import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gasto.dart';

class GastoDatabase {
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'gastos.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE gastos(id INTEGER PRIMARY KEY AUTOINCREMENT, valor REAL, descricao TEXT, moeda TEXT, simbolo TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertGasto(Gasto gasto) async {
    final db = await openDB();
    await db.insert('gastos', gasto.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Gasto>> getGastos() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('gastos');
    return List.generate(maps.length, (i) {
      return Gasto(
        id: maps[i]['id'],
        valor: maps[i]['valor'],
        descricao: maps[i]['descricao'],
        moeda: maps[i]['moeda'],
        simbolo: maps[i]['simbolo'],
      );
    });
  }
}