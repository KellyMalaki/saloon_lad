import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final bool firstScreen;
  const Loading({Key? key, required this.firstScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(firstScreen){
      return Container(
        color: Colors.purple[50],
        child: const Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    }else{
      return Container(
        color: Colors.blue[50],
        child: const Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    }
  }
}

