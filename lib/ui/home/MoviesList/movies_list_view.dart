import 'package:flutter/material.dart';
import 'package:movies_app/ui/Home/MoviesList/movies_list_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/utils/spinner_widget.dart';
import 'package:movies_app/data/pojo/database.dart';
import'package:movies_app/data/pojo/movie.dart';
import 'package:movies_app/data/floor_db/movie_dao.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}


class _MoviesListState extends State<MoviesList> {

  MovieDao? glbDao;

  Future<void> createDB() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final dao = database.movieDao;

    glbDao = dao;
  }

  // Get Movie data from MovieAPI Class
  MoviesAPI myinstance = MoviesAPI();
  List<Movie> mylist = [Movie(id: 0, overview: "", title: "", poster_path: "", is_fav: false)] ;
  List<Movie> mylistdb = [Movie(id: 0, overview: "", title: "", poster_path: "", is_fav: false)] ;
  String ImgPath = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';


  Future<List<Movie>> setupMovies() async {
    mylist = await myinstance.getMovies();
    mylistdb = (await glbDao?.findAllMovies())!;
    var counter = 0;
    for (var i in mylist){
      if (mylistdb.length > counter){
        if (i.id == mylistdb[counter].id){
          i.is_fav = true;
        }
      }
      counter += 1;
    }
    return mylist;
  }
  // Initialize with the same length as mylist and with only falses
  // late is for
  late List<bool> _isfavorites = mylist.map((e) => false).toList();

  // Favorite Button Logic Function
  bool handleFavorite(_isfavorite, Movie movie){
    glbDao?.insertMovie(movie);
    return !_isfavorite;
  }

  bool removeFavorite(Movie movie, bool _isfavorite){
    glbDao?.removeMovie(movie);
    return !_isfavorite;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDB();
    setupMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      body: Stack(
        children: [
          FutureBuilder<List<Movie>>(
              future: setupMovies(),
              builder: (context, snapshot){
                var count = snapshot.data?.length ?? 0;
                if (count > 1){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index){

                        var title = snapshot.data?[index].title;
                        var overview = snapshot.data?[index].overview;
                        var is_fav = snapshot.data?[index].is_fav;
                        print(is_fav);
                        var poster_path = snapshot.data?[index].poster_path;
                        var movie_id = snapshot.data?[index].id;

                        for (var i in mylistdb){
                          if (i.id == movie_id){
                            is_fav = true;
                          }
                        }

                        final _isfavorie = is_fav;

                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: ListTile(
                                    enabled: false,
                                    onTap: () {
                                      //updateTime(index);
                                      print('locations[index].location');
                                    },
                                    title: Text(
                                      title ?? '',
                                      style: TextStyle(
                                          color: Colors.blueGrey
                                      ),),
                                    subtitle: Text(
                                      overview ?? '',
                                      maxLines: 2,
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          (ImgPath + (poster_path ?? ''))
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                onPressed: () => setState(() => _isfavorie! ? removeFavorite(snapshot.data![index], _isfavorie) : handleFavorite(_isfavorie, snapshot.data![index])),
                                color: Colors.red,
                                icon:   _isfavorie! ?  Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }else{
                  return Stack(
                      children: [

                        Positioned(
                            top: MediaQuery.of(context).size.height/2,
                            left: (MediaQuery.of(context).size.width/4),
                            right: (MediaQuery.of(context).size.width/4),
                            child: Center(
                                child: Text(
                                  'No Internet',
                                  style: TextStyle(
                                      fontSize: 20,
                                      wordSpacing: 2,
                                      color: Colors.red
                                  ),
                                )
                            )
                        ),
                        Positioned(
                            top: MediaQuery.of(context).size.height/2 + 30,
                            left: (MediaQuery.of(context).size.width/4),
                            right: (MediaQuery.of(context).size.width/4),
                            child: IconButton(
                              onPressed: (() {
                                setState(() {
                                  setupMovies();
                                });

                              }),
                              icon: Icon(Icons.refresh_rounded),
                              color: Colors.blue,
                            )
                        )
                      ]
                  );
                }
              }),
          //Spinner_Widget()
        ],
      ),
    );
  }
}
