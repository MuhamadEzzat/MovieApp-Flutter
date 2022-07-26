import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner_Widget extends StatelessWidget {
  const Spinner_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Center(
          child: Container(
            height: 80,
            width: 80,
            color: Colors.grey.withOpacity(0.5),
            child: SpinKitFadingCircle(
              color: Colors.black87,
              size: 40.0,
            ),
          ),
        )
    );
  }
}
