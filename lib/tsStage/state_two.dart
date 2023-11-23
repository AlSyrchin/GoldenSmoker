class StateTwo {
  final String name;
  final double tbox;
  final double tprod;
  final int time;
  final bool extractor;
  final bool smoke;
  final bool water;
  final bool flap;
  final bool tens;
  final List<bool> btnList;

  StateTwo({
    this.name = '',
    this.tbox = 0,
    this.tprod = 0,
    this.time = 0,
    this.extractor = false,
    this.smoke = false,
    this.water = false,
    this.flap = false,
    this.tens = false,
    this.btnList = const [true,false,false,false,false,false]
  });

  StateTwo copyWith({
    String? name,
    double? tbox,
    double? tprod,
    int? time,
    bool? extractor,
    bool? smoke,
    bool? water,
    bool? flap,
    bool? tens,
    List<bool>? btnList,
  }) {
    return StateTwo(
      name: name ?? this.name,
      tbox: tbox ?? this.tbox,
      tprod: tprod ?? this.tprod,
      time: time ?? this.time,
      extractor: extractor ?? this.extractor,
      smoke: smoke ?? this.smoke,
      water: water ?? this.water,
      flap: flap ?? this.flap,
      tens: tens ?? this.tens,
      btnList: btnList ?? this.btnList,
    );
  }
}