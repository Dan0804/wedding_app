part of 'calender.dart';

class CalenderDetail extends StatefulWidget {
  const CalenderDetail({super.key});

  @override
  State<CalenderDetail> createState() => _CalenderDetailState();
}

class _CalenderDetailState extends State<CalenderDetail> {
  @override
  Widget build(BuildContext context) {
    _CalenderState();

    return ValueListenableBuilder<List<Events>>(
        valueListenable: _CalenderState()._selectEvents,
        builder: (context, value, _) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                color: Colors.black12,
                child: SizedBox(
                  height: 64,
                  child: Center(
                    child: Text("test"),
                  ),
                ),
              );
            },
          );
        });
  }
}
