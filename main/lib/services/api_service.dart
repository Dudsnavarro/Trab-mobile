import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_game.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/video_games';

  // Função para buscar todos os videogames
  Future<List<VideoGame>> fetchVideoGames() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => VideoGame.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os videogames');
    }
  }

  // Função para dar um lance (atualizar current_bid)
Future<void> placeBid(int id, double newBid) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'current_bid': newBid, // Garantir que o lance é enviado como double
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao dar o lance');
    }
  } catch (e) {
    throw Exception('Erro ao tentar dar o lance: $e');
  }
}

  // Função para criar um novo videogame
  Future<VideoGame> createVideoGame(VideoGame videoGame) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(videoGame.toJson()),
    );
    if (response.statusCode == 201) {
      return VideoGame.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar videogame');
    }
  }

  // Função para atualizar um videogame
  Future<void> updateVideoGame(int id, VideoGame videoGame) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(videoGame.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar videogame');
    }
  }

  // Função para deletar um videogame
  Future<void> deleteVideoGame(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar videogame');
    }
  }
}
