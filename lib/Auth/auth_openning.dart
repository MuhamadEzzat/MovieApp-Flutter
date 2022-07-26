import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth_Openning extends StatelessWidget {
  const Auth_Openning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.black87,
        elevation: 0.5,

      ),
      body: Container(
        // In order to make container's size as the screen's size
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.fill
          ),
        ),

        child: Column(
          children: [
            Divider(height: 48,),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image:  DecorationImage(
                    image: AssetImage('assets/login.jpg')
                ),
              ),
              // child: Image(
              //   image: AssetImage('assets/login.jpg'),
              // ),
            ),

            Divider(height: 32,),

            SizedBox(
              width: 180,
              height: 30,
              child: ElevatedButton(
                onPressed:(() {
                  Navigator.pushNamed(context, '/login');
                }),
                child: Text(
                    'Login'
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,

                ),
              ),
            ),
            Divider(height: 16,),
            SizedBox(
              width: 180,
              height: 30,
              child: ElevatedButton(
                onPressed: (() {
                  Navigator.pushNamed(context, '/signup');
                }),
                child: Text(
                    'Signup'
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
