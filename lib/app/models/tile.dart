class Tile {
  final int tileId;
  final String tileTitle;
  final int budget;
  final DateTime deadline;
  final String cardStatus;

  Tile({
    required this.tileId,
    required this.tileTitle,
    required this.budget,
    required this.deadline,
    required this.cardStatus,
  });

  factory Tile.fromJson(Map<String, dynamic> json) {
    return Tile(
      tileId: json['cardId'],
      tileTitle: json['cardTitle'],
      budget: json['budget'],
      deadline: DateTime.parse(json['deadline']),
      cardStatus: json['cardStatus'],
    );
  }
}
