import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:movies_app/movie.dart';


class MoviesAPI {
  Movie movie = Movie(overview: '', title: '', poster_path: '', is_fav: false);
  List<Movie> movies = [];

  Future<List<Movie>> getMovies() async {

    try{
      // Make a request
      var url = Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=92346f3b534399fdc62122746fcb80b1&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate');
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      // Get properties
      List<dynamic> results = data['results'];
      for (var i in results){
        Movie instance = Movie(overview: i['overview'], title: i['title'], poster_path: i['poster_path'], is_fav: false,id: i['id']);
        movies.add(instance);
      }
    }
    catch (error){
      print(error);
    }

    return movies;
  }
}