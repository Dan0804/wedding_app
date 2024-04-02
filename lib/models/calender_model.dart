class Events {
  final String title;
  Events(this.title);
}

final DateTime utcTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

Map<DateTime, List<Events>> events = {};
