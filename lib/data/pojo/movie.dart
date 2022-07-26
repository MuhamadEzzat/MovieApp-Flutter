import 'package:floor/floor.dart';

@entity
class Movie {
  @PrimaryKey()

  int? id;

  String? overview = '';

  String? title = '';

  String? poster_path = '';

  bool? is_fav = false;

  Movie({this.id, this.overview, this.title, this.poster_path, this.is_fav});
}