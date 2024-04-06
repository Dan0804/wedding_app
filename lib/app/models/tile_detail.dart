class TileDetail {
  final int tileId;
  final int toDoId;
  final bool toDoStatus;
  final String toDoText;

  TileDetail({
    required this.tileId,
    required this.toDoId,
    required this.toDoStatus,
    required this.toDoText,
  });

  factory TileDetail.fromJson(Map<String, dynamic> json) {
    return TileDetail(
      tileId: json['cardId'],
      toDoId: json['toDoId'],
      toDoStatus: json['toDoStatus'],
      toDoText: json['toDoText'],
    );
  }
}
