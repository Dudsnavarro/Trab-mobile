import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AuctionApp());
}

class AuctionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leilão de Videogames',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
