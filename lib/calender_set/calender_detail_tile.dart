part of 'calender.dart';

class CalenderDetail extends StatefulWidget {
  const CalenderDetail({
    super.key,
    required this.textTile,
  });

  final bool textTile;

  @override
  State<CalenderDetail> createState() => _CalenderDetailState();
}

class _CalenderDetailState extends State<CalenderDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TileService>(
      builder: (context, tileService, child) => ListView.builder(
        shrinkWrap: true,
        itemCount: widget.textTile ? tileService.selectedEventsInTile.length : tileService.selectedEventsInCalender.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            color: Colors.black12,
            child: SizedBox(
              height: 64,
              child: Center(
                child: Text(widget.textTile ? tileService.selectedEventsInTile[index].title : tileService.selectedEventsInCalender[index].title),
              ),
            ),
          );
        },
      ),
    );
  }
}
