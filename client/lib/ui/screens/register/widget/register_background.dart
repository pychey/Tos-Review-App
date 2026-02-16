import 'package:flutter/material.dart';

Widget background(){
  return Container(
    width: double.infinity,
    height: 700,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 1.0], 
        colors: [Color.fromARGB(255, 196, 230, 226), Colors.white],
      ),
    ),
  );
}