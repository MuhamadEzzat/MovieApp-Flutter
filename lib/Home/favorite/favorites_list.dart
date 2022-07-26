import 'package:flutter/material.dart';
import 'package:movies_app/Home/spinner_widget.dart';
import 'package:movies_app/database.dart';
import 'package:movies_app/movie.dart';
import 'package:movies_app/movie_dao.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Favorites_list extends StatefulWidget {
  const Favorites_list({Key? key}) : super(key: key);

  @override
  State<Favorites_list> createState() => _Favorites_listState();
}

class _Favorites_listState extends State<Favorites_list> {

  MovieDao? glbDao;
  String ImgPath = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2';

  Future<List<Movie>> createDB() async {

      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final dao = database.movieDao;

      glbDao = dao;
      return dao.findAllMovies();
  }

  Future<void> removeMovie(index, context) async {
    FutureBuilder<List<Movie>>(
      builder: (context, snapshot){
        print(snapshot.data![index].id);
        return Spinner_Widget();
      },
      future: glbDao?.findAllMovies(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Movie>>(
              future: createDB(),
              builder: (context, snapshot){
                var count = snapshot.data?.length ?? 0;
                print(' counter is : $count');
                if (count > 0){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index){

                        var title = snapshot.data?[index].title;
                        var overview = snapshot.data?[index].overview;
                        var is_fav = snapshot.data?[index].is_fav;
                        var poster_path = snapshot.data?[index].poster_path;
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
                                onPressed: () => setState(() {
                                  glbDao?.removeMovie(snapshot.data![index]);
                                  }),
                                color: Colors.red,
                                icon: Icon(Icons.remove)
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
                            child: Center(
                                child: Text(
                                  'No Favorite Movies Selected',
                                  style: TextStyle(
                                      fontSize: 20,
                                      wordSpacing: 2,
                                      color: Colors.red
                                  ),
                                )
                            )
                        ),
                      ]
                  );
                }
              }),
        ],
      ),
    );
  }
}
