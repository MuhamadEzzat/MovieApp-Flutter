import 'package:floor/floor.dart';
import 'package:movies_app/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> findAllMovies();

  @insert
  Future<void> insertMovie(Movie movie);

  @delete
  Future<void> removeMovie(Movie movie);
}