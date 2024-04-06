class ToDo {
  final int tileId;
  final int toDoId;
  final bool toDoStatus;
  final String toDoText;

  ToDo({
    required this.tileId,
    required this.toDoId,
    required this.toDoStatus,
    required this.toDoText,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      tileId: json['cardId'],
      toDoId: json['toDoId'],
      toDoStatus: json['toDoStatus'],
      toDoText: json['toDoText'],
    );
  }
}
