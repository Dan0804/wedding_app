class CheckBoxs {
  bool isChecked;
  String text;

  CheckBoxs(this.isChecked, this.text);
}

class Tiles {
  String title;
  final String tileId;
  final String userId;
  int state;
  DateTime arrangeDate;
  List<CheckBoxs> checkBoxs;

  Tiles(
    this.title,
    this.tileId,
    this.userId,
    this.state,
    this.arrangeDate,
    this.checkBoxs,
  );

  /* Tiles 구성
      title(String) : tile의 title
      tileId(String) : 난수로 형성?
      userId(String) : 난수로 형성?
      state(int) : 0(Backlog), 1(Progress), 2(Done)으로 구분하기
      arrangeDate(DateTime) : 1994.8.4는 날짜를 선택하지 않았을 시 default값, 선택하면 그 날로 입력
      checkBoxs(List<CheckBoxs>) : CheckBoxs class에는 isChecked와 text만 넣기
  */
}
