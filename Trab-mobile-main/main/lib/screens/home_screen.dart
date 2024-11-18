import 'package:flutter/material.dart';
import 'auction_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leilão de Videogames')),
      body: Center(
        child: ElevatedButton(
          child: Text('Ver Videogames no Leilão'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuctionListScreen()),
            );
          },
        ),
      ),
    );
  }
}
