class StateFive {
  final double temperature;
  final double tbox;
  final double tprod;
  final List<bool> btnExtractor;
  final List<bool> btnSmoke;
  final List<bool> btnWater;
  final List<bool> btnFlap;
  final List<bool> btnTens;
  final bool tboxUp;
  final bool tprodUp;
  StateFive({
    this.temperature = 0,
    this.tbox = 0.0,
    this.tprod = 0.0,
    this.btnExtractor = const [true,false],
    this.btnSmoke = const [false, true],
    this.btnWater = const [true,false],
    this.btnFlap = const [true,false],
    this.btnTens = const [true,false],
    this.tboxUp = false,
    this.tprodUp = false,
  });

  StateFive copyWith({
    double? temperature,
    double? tbox,
    double? tprod,
    List<bool>? btnExtractor,
    List<bool>? btnSmoke,
    List<bool>? btnWater,
    List<bool>? btnFlap,
    List<bool>? btnTens,
    bool? tboxUp,
    bool? tprodUp,
  }) {
    return StateFive(
      temperature: temperature ?? this.temperature,
      tbox: tbox ?? this.tbox,
      tprod: tprod ?? this.tprod,
      btnExtractor: btnExtractor ?? this.btnExtractor,
      btnSmoke: btnSmoke ?? this.btnSmoke,
      btnWater: btnWater ?? this.btnWater,
      btnFlap: btnFlap ?? this.btnFlap,
      btnTens: btnTens ?? this.btnTens,
      tboxUp: tboxUp ?? this.tboxUp,
      tprodUp: tprodUp ?? this.tprodUp,
    );
  }
}
