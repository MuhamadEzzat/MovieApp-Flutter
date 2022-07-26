import 'package:flutter/material.dart';
import 'package:movies_app/ui/Auth/Login/login_view.dart';
import 'package:movies_app/ui/Auth/auth_openning.dart';
import 'package:movies_app/ui/Auth/Signup/signup_view.dart';
import 'package:movies_app/ui/Home/MoviesList/movies_list_view.dart';
import 'package:movies_app/ui/Home/home_page.dart';
import 'package:movies_app/ui/Home/MoviesList/movies_list_view.dart';
import 'package:movies_app/ui/Home/favorite/favorites_list.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/auth_openning',

  routes: {
    '/auth_openning': (context) => const Auth_Openning(),
    '/login': (context) => const LoginPage(),
    '/signup': (context) => const SignupPage(),
    '/home': (context) =>  const HomePage(),
    '/movie_list': (context) => const MoviesList(),
    '/favorite_list': (context) => const Favorites_list()
  },
));
