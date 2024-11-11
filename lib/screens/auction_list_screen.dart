import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/video_game.dart';
import 'video_game_form_screen.dart';

class AuctionListScreen extends StatefulWidget {
  @override
  _AuctionListScreenState createState() => _AuctionListScreenState();
}

class _AuctionListScreenState extends State<AuctionListScreen> {
  late Future<List<VideoGame>> videoGames;
  final TextEditingController _bidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videoGames = ApiService().fetchVideoGames();
  }

  void _placeBid(int id, double newBid, double currentBid) async {
    if (newBid <= currentBid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('O lance deve ser maior que o valor atual de R\$ $currentBid'),
      ));
      return;
    }

    try {
      await ApiService().placeBid(id, newBid);

      setState(() {
        videoGames = ApiService().fetchVideoGames();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lance de R\$ $newBid realizado com sucesso!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao dar o lance. Tente novamente.'),
      ));
    }
  }

  void _deleteVideoGame(int id) async {
    await ApiService().deleteVideoGame(id);
    setState(() {
      videoGames = ApiService().fetchVideoGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leilão de Videogames')),
      body: FutureBuilder<List<VideoGame>>(
        future: videoGames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          List<VideoGame> videoGames = snapshot.data ?? [];
          return ListView.builder(
            itemCount: videoGames.length,
            itemBuilder: (context, index) {
              final videoGame = videoGames[index];
              return ListTile(
                title: Text(videoGame.name),
                subtitle: Text('Lance atual: R\$${videoGame.currentBid}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botão de lance
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        // Exibe o campo para o lance
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Dar um Lance'),
                              content: TextField(
                                controller: _bidController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Valor do lance',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final newBid = double.tryParse(_bidController.text);
                                    if (newBid != null) {
                                      _placeBid(videoGame.id, newBid, videoGame.currentBid);
                                      _bidController.clear();
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('Por favor, insira um valor válido.'),
                                      ));
                                    }
                                  },
                                  child: Text('Confirmar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    // Botão de edição
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoGameFormScreen(videoGame: videoGame),
                          ),
                        );
                      },
                    ),
                    // Botão de exclusão
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteVideoGame(videoGame.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoGameFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
