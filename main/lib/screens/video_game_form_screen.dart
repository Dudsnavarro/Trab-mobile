import 'package:flutter/material.dart';
import '../models/video_game.dart';

class VideoGameFormScreen extends StatefulWidget {
  final VideoGame? videoGame;

  VideoGameFormScreen({this.videoGame});

  @override
  _VideoGameFormScreenState createState() => _VideoGameFormScreenState();
}

class _VideoGameFormScreenState extends State<VideoGameFormScreen> {
  late TextEditingController _nameController;
  late TextEditingController _currentBidController;
  late TextEditingController _yearController;
  late TextEditingController _startingBidController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os valores existentes ou campos vazios
    _nameController = TextEditingController(text: widget.videoGame?.name ?? '');
    _currentBidController = TextEditingController(text: widget.videoGame?.currentBid.toString() ?? '');
    _yearController = TextEditingController(text: widget.videoGame?.year.toString() ?? '');
    _startingBidController = TextEditingController(text: widget.videoGame?.startingBid.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentBidController.dispose();
    _yearController.dispose();
    _startingBidController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final name = _nameController.text;
    final currentBid = double.tryParse(_currentBidController.text);
    final year = int.tryParse(_yearController.text);
    final startingBid = double.tryParse(_startingBidController.text);

    if (name.isEmpty || currentBid == null || year == null || startingBid == null) {
      // Se algum campo obrigatório estiver vazio, exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preencha todos os campos corretamente!')));
      return;
    }

    // Criação ou atualização do videogame
    final videoGame = VideoGame(
      id: widget.videoGame?.id ?? 0, // Se for novo, o id será 0
      name: name,
      currentBid: currentBid,
      year: year,
      startingBid: startingBid,
    );

    // Aqui você pode chamar a função para salvar no backend, por exemplo:
    // ApiService().saveVideoGame(videoGame);

    Navigator.pop(context, videoGame); // Retorna o videogame para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoGame == null ? 'Adicionar VideoGame' : 'Editar VideoGame'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _currentBidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Lance Atual'),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ano de Lançamento'),
            ),
            TextField(
              controller: _startingBidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Lance Inicial'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text(widget.videoGame == null ? 'Salvar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
