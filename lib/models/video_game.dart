class VideoGame {
  final int id;
  final String name;
  double currentBid;
  final int year;
  final double startingBid;

  VideoGame({
    required this.id,
    required this.name,
    required this.currentBid,
    required this.year,
    required this.startingBid,
  });

  factory VideoGame.fromJson(Map<String, dynamic> json) {
  return VideoGame(
    id: int.tryParse(json['id'].toString()) ?? json['id'],
    name: json['name'],
    currentBid: (json['current_bid'] is String)
        ? double.parse(json['current_bid'])
        : (json['current_bid'] as num).toDouble(),
    year: int.tryParse(json['year'].toString()) ?? json['year'],
    startingBid: (json['starting_bid'] is String)
        ? double.parse(json['starting_bid'])
        : (json['starting_bid'] as num).toDouble(),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'current_bid': currentBid,
      'year': year,
      'starting_bid': startingBid,
    };
  }
}
