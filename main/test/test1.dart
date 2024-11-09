import 'package:flutter_test/flutter_test.dart';
import 'package:main/models/video_game.dart';

void main() {
  group('VideoGame', () {
    test('deve criar um objeto VideoGame a partir do JSON', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'name': 'Super Nintendo',
        'current_bid': 150.0,
        'year': 1990,
        'starting_bid': 100.0,
      };

      final videoGame = VideoGame.fromJson(json);

      expect(videoGame.id, 1);
      expect(videoGame.name, 'Super Nintendo');
      expect(videoGame.currentBid, 150.0);
      expect(videoGame.year, 1990);
      expect(videoGame.startingBid, 100.0);
    });
  });
}
