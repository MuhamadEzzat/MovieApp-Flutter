import 'package:flutter/material.dart';
import 'package:movies_app/ui/Home/MoviesList/movies_list_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/assets/moviesbg.jpg'),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed:(() {
                  Navigator.pushNamed(context, '/movie_list');
                }),
                child: Text(
                    'Movies'
                ),

                style: ElevatedButton.styleFrom(
                  primary: Colors.black38,

                ),
              ),
            ),
            Divider(height: 16,),
            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed:(() {
                  Navigator.pushNamed(context, '/favorite_list');
                }),
                child: Text(
                    'My Favorites'
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
