import 'package:flutter/material.dart';

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