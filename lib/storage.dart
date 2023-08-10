import 'dart:ffi';
import 'dart:math';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

final int top = 25;

class History {
  static const _databaseName = 'history.db';
  static const _databaseVersion = 1;
  static Database? _database;
  static const table = 'history';

  History._privateConstructor();
  static final History instance = History._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE History (
      name TEXT NOT NULL,
      date DATETIME NOT NULL,
      percentage REAL NOT NULL,
      amount REAL NOT NULL,
      total_amount REAL NOT NULL,
      PRIMARY KEY (name, date)
    );
  ''');
  }

  static Future<void> insert(String name, DateTime date, Float percentage,
      Float amount, Float total_amount) async {
    // Insert the new record
    await _database!.insert(table, {
      "name": name,
      "date": date.toIso8601String(),
      "percentage": percentage,
      "amount": amount,
      "total_amount": total_amount,
    });
  }

  static Future<List<Map<String, dynamic>>> query() async {
    final List<Map<String, dynamic>> results = await _database!.query(
      table,
      orderBy: 'date DESC',
      limit: top,
    );
    return results;
  }
}
