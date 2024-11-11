import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_game.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/video_games';

  Future<List<VideoGame>> fetchVideoGames() async {
  try {
    print('Tentando conectar ao JSON Server em $baseUrl');
    final response = await http.get(Uri.parse(baseUrl));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => VideoGame.fromJson(json)).toList();
    } else {
      print('Erro ao carregar os videogames: Status ${response.statusCode}');
      throw Exception('Falha ao carregar os videogames');
    }
  } catch (e) {
    print('Erro na conexão com o backend: $e');
    throw Exception('Erro de conexão');
  }
}


Future<void> placeBid(int id, double newBid) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'current_bid': newBid,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao dar o lance');
    }
  } catch (e) {
    throw Exception('Erro ao tentar dar o lance: $e');
  }
}


Future<VideoGame> createVideoGame(VideoGame videoGame) async {
  try {
    print('Tentando criar um novo videogame com dados: ${videoGame.toJson()}');

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(videoGame.toJson()),
    );

    print('Resposta do servidor: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 201) {
      return VideoGame.fromJson(json.decode(response.body));
    } else {
      print('Erro ao criar videogame. Resposta do servidor: ${response.body}');
      throw Exception('Falha ao criar videogame. Código de status: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao tentar criar videogame: $e');
    throw Exception('Erro ao tentar criar videogame: $e');
  }
}


  Future<void> updateVideoGame(int id, VideoGame videoGame) async {
  print('Tentando atualizar o leilão $id com dados: ${videoGame.toJson()}'); 

  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(videoGame.toJson()),
  );

  print('Resposta do servidor (update): ${response.statusCode} - ${response.body}'); 
  if (response.statusCode != 200) {
    throw Exception('Falha ao atualizar videogame');
  }
}

  Future<void> deleteVideoGame(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar videogame');
    }
  }
}
