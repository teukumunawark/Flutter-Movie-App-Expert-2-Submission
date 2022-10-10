import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../../models/tv_series_table.dart';

class TvSeriesDatabaseHelper {
  static TvSeriesDatabaseHelper? _tvSeriesdatabaseHelper;
  TvSeriesDatabaseHelper._instance() {
    _tvSeriesdatabaseHelper = this;
  }

  factory TvSeriesDatabaseHelper() =>
      _tvSeriesdatabaseHelper ?? TvSeriesDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTvSeries = 'watchlistTvSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/tvseries.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // Tv Series Table
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  // Insert Watch List Tv Series
  Future<int> insertWatchlistTvSeries(TvSeriesTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvSeries, tv.toJson());
  }

  // Remove Watch List Tv Series
  Future<int> removeWatchlistTvSeries(TvSeriesTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  // Get Tv Series By ID
  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  // Get Watch List Tv Series
  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvSeries);

    return results;
  }
}
