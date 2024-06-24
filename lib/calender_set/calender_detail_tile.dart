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
  String addRest(budget) {
    int intBudget = budget.toInt();
    String budgetRest = NumberFormat('₩ ###,###,###,###').format(intBudget);
    return budgetRest;
  }

  @override
  Widget build(BuildContext context) {
    var tilesForDay = context.watch<FetchTileApi>().tilesForDay;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tilesForDay.length,
      itemBuilder: (context, index) {
        var tile = tilesForDay[index];
        return Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tile.tileTitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Budget: ${addRest(tile.budget)}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
