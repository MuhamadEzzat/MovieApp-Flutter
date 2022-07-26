import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  TextEditingController confirmpasscontroller = new TextEditingController();

  bool _validatePass = true;
  bool _validateUsername = true;
  bool _validateConfirm = true;


  void SignupToMoviesList(context) async{
    final prefs = await SharedPreferences.getInstance();

    validateUsername(usernamecontroller.text);
    validatePassword(passcontroller.text);
    validateConfirm(confirmpasscontroller.text);

    if (_validateUsername != false && _validatePass != false && _validateConfirm != false){
      await prefs.setString('username', usernamecontroller.text);
      await prefs.setString('pass', passcontroller.text);
      Navigator.pushNamed(context, '/home');
    }

  }

  void validateUsername(String value){
    if (value.length > 12 || value.length < 5){
      _validateUsername = false;
    }else{
      _validateUsername = true;
    }
  }

  void validatePassword(String value){
    if (value.length > 10 || value.length < 5 && !value.contains('@')){
      _validatePass = false;
    }else{
      _validatePass = true;
    }
  }

  void validateConfirm(String value){
    if (value != passcontroller.text){
      _validateConfirm = false;
    }else{
      _validateConfirm = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Signup'
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
            TextField(
              controller: confirmpasscontroller,
              obscureText: true,
              decoration: InputDecoration(
                  labelText:'Confirm Password',
                  prefixIcon:Icon(Icons.password),
                  errorText: _validateConfirm ?  null : "Password doesn't match."
              ),
            ),
            ElevatedButton(
              onPressed: (()
              {
                setState(() {
                  SignupToMoviesList(context);
                });
              }
              ),
              child: Text(
                  'Signup'
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
