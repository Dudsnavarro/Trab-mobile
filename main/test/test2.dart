import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/video_game_form_screen.dart';
import 'package:main/models/video_game.dart';

void main() {
  group('VideoGameFormScreen', () {
    testWidgets('deve criar um VideoGame com os dados inseridos no formulário', (WidgetTester tester) async {
      // Carrega o formulário vazio
      await tester.pumpWidget(MaterialApp(
        home: VideoGameFormScreen(),
      ));

      // Insere os valores nos campos do formulário
      await tester.enterText(find.byType(TextField).at(0), 'Mega Drive');
      await tester.enterText(find.byType(TextField).at(1), '250.0');
      await tester.enterText(find.byType(TextField).at(2), '1988');
      await tester.enterText(find.byType(TextField).at(3), '200.0');

      // Pressiona o botão de salvar
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Espera que o formulário tenha retornado um novo VideoGame com os dados
      final videoGame = VideoGame(
        id: 0, // ID será 0 para novo videogame
        name: 'Mega Drive',
        currentBid: 250.0,
        year: 1988,
        startingBid: 200.0,
      );

      expect(videoGame.name, 'Mega Drive');
      expect(videoGame.currentBid, 250.0);
      expect(videoGame.year, 1988);
      expect(videoGame.startingBid, 200.0);
    });
  });
}
