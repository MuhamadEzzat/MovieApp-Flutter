import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();

  bool _validatePass = true;
  bool _validateUsername = true;

  void LoginToMoviesList(context) async{

    final prefs = await SharedPreferences.getInstance();

    validateUsername(usernamecontroller.text);
    validatePassword(passcontroller.text);

    if (_validateUsername != false && _validatePass != false) {
      if (usernamecontroller.text == prefs.getString("username") && passcontroller.text == prefs.getString('pass')){
        Navigator.pushNamed(context, '/home');

      }else{
        showDialog(
            context: context,
            builder: (BuildContext context){
              return InvalidLoginAlert();
            }
        );
      }

    }

  }

  String validateUsername(String value){
    if (value.length > 12 || value.length < 5){
      _validateUsername = false;
      return 'Please enter Username greater than 5 & less than 10 characters.';
    }else{
      _validateUsername = true;
    }
    return '';
  }

  String validatePassword(String value){
    if (value.length > 10 || value.length < 5 && !value.contains('@')){
      _validatePass = false;
      return 'Please enter password greater than 5 & less than 10 characters.';
    }else{
      _validatePass = true;
    }
    return '';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login'
        ),
        backgroundColor: Colors.black87,
      ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(36.0, 48.0, 36.0, 0.0),
      child: Column(
        children: [
          TextField(
            controller: usernamecontroller,
          decoration: InputDecoration(
              labelText:'Username',
              prefixIcon:Icon(Icons.person),
              errorText: _validateUsername ? null : 'Please enter Username greater than 5 & less than 10 characters.'
          ),
          ),
          TextField(
            controller: passcontroller,
            obscureText: true,
            decoration: InputDecoration(
                labelText:'Password',
                prefixIcon:Icon(Icons.password),
                errorText: _validatePass ?  null : 'Please enter password greater than 5 & less than 10 characters.'
            ),
          ),
          ElevatedButton(
            onPressed: (()
            {
              setState(() {
                LoginToMoviesList(context);
              });
            }
            ),
            child: Text(
                'Login'
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,

            ),
          ),
        ],
      ),
    ),
    );
  }
}

class InvalidLoginAlert extends StatelessWidget {
  const InvalidLoginAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content: const Text('Invalid Username or Password'),

      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('OK')
        ),
      ],
    );
  }
}

