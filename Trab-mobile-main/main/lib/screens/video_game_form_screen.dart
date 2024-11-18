import 'package:flutter/material.dart';
import '../models/video_game.dart';
import '../services/api_service.dart';

class VideoGameFormScreen extends StatefulWidget {
  final VideoGame? videoGame; // Pode ser nulo para criação

  const VideoGameFormScreen({Key? key, this.videoGame}) : super(key: key);

  @override
  _VideoGameFormScreenState createState() => _VideoGameFormScreenState();
}

class _VideoGameFormScreenState extends State<VideoGameFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  late TextEditingController nameController;
  late TextEditingController yearController;
  late TextEditingController startingBidController;
  late TextEditingController currentBidController;

  @override
  void initState() {
    super.initState();

    // Inicializar os controladores com os valores do leilão ou vazios para criação
    nameController = TextEditingController(text: widget.videoGame?.name ?? '');
    yearController = TextEditingController(
        text: widget.videoGame != null ? widget.videoGame!.year.toString() : '');
    startingBidController = TextEditingController(
        text: widget.videoGame != null
            ? widget.videoGame!.startingBid.toString()
            : '');
    currentBidController = TextEditingController(
        text: widget.videoGame != null
            ? widget.videoGame!.currentBid.toString()
            : '');
  }

  @override
  void dispose() {
    nameController.dispose();
    yearController.dispose();
    startingBidController.dispose();
    currentBidController.dispose();
    super.dispose();
  }

  // Função para salvar o leilão
  void _saveVideoGame() async {
    if (_formKey.currentState!.validate()) {
      final newVideoGame = VideoGame(
        id: widget.videoGame?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        year: int.parse(yearController.text),
        startingBid: double.parse(startingBidController.text),
        currentBid: double.parse(currentBidController.text),
      );

      try {
        if (widget.videoGame == null) {
          // Criar novo leilão
          await ApiService().createVideoGame(newVideoGame);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Leilão criado com sucesso!')),
          );
        } else {
          // Atualizar leilão existente
          await ApiService().updateVideoGame(widget.videoGame!.id, newVideoGame);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Leilão atualizado com sucesso!')),
          );
        }
        Navigator.pop(context, true); // Retorna ao fechar a tela
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar leilão: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.videoGame != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Leilão' : 'Novo Leilão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome não pode estar vazio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: yearController,
                  decoration: InputDecoration(labelText: 'Ano'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O ano não pode estar vazio';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Insira um ano válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: startingBidController,
                  decoration: InputDecoration(labelText: 'Lance Inicial'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O lance inicial não pode estar vazio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: currentBidController,
                  decoration: InputDecoration(labelText: 'Lance Atual'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O lance atual não pode estar vazio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: _saveVideoGame,
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
