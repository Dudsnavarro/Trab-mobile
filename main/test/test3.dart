import 'package:flutter_test/flutter_test.dart';
import 'package:main/models/video_game.dart';

void main() {
  group('VideoGame', () {
    test('deve atualizar o lance atual ao dar um novo lance', () {
      // Cria um videogame com um lance inicial
      final videoGame = VideoGame(
        id: 1,
        name: 'Super Nintendo',
        currentBid: 150.0,
        year: 1990,
        startingBid: 100.0,
      );

      // Aumenta o lance em 50.0
      final double newBid = 200.0;
      videoGame.currentBid = newBid;

      // Verifica se o lance foi atualizado corretamente
      expect(videoGame.currentBid, newBid);
    });
  });
}
