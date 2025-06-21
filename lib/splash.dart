import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vivi/main.dart';

class love extends StatefulWidget {
  const love({super.key});

  @override
  State<love> createState() => _loveState();
}

class _loveState extends State<love> {
  // hum yaha pt after splash scrren ka logic likhnege

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dash()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(child: Container(child: Text("hello"))),
      ),
    );
  }
}
