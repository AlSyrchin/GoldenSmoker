class StateCooking {
  final int activePage;
  final double tbox;
  final double tprod;
  final int time;
  final bool lamp;
  final int cookingPage;

  StateCooking({
    this.activePage = 0,
    this.tbox = 0,
    this.tprod = 0,
    this.time = 0,
    this.lamp = false,
    this.cookingPage = 0,
  });

  StateCooking copyWith({
    int? activePage,
    double? tbox,
    double? tprod,
    int? time,
    bool? lamp,
    int? cookingPage,
  }) {
    return StateCooking(
      activePage: activePage ?? this.activePage,
      tbox: tbox ?? this.tbox,
      tprod: tprod ?? this.tprod,
      time: time ?? this.time,
      lamp: lamp ?? this.lamp,
      cookingPage: cookingPage ?? this.cookingPage,
    );
  }
}
