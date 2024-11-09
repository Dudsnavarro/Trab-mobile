class VideoGame {
  final int id;
  final String name;
  double currentBid;
  final int year; // Adicionado campo 'year'
  final double startingBid; // Adicionado campo 'startingBid'

  VideoGame({
    required this.id,
    required this.name,
    required this.currentBid,
    required this.year, // Inicializando 'year'
    required this.startingBid, // Inicializando 'startingBid'
  });

  // Função para converter de JSON para objeto VideoGame
  factory VideoGame.fromJson(Map<String, dynamic> json) {
    return VideoGame(
      id: json['id'],
      name: json['name'],
      currentBid: json['current_bid'] is int ? json['current_bid'].toDouble() : json['current_bid'],
      year: json['year'], // Atribuindo 'year' do JSON
      startingBid: json['starting_bid'] is int ? json['starting_bid'].toDouble() : json['starting_bid'], // Atribuindo 'starting_bid' do JSON
    );
  }

  // Função para converter de VideoGame para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'current_bid': currentBid,
      'year': year, // Incluindo 'year' no JSON
      'starting_bid': startingBid, // Incluindo 'starting_bid' no JSON
    };
  }
}
