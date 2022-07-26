// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:movies_app/data/floor_db/movie_dao.dart';
import 'movie.dart';
part '../floor_db/database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Movie])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}