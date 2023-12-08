class StateChat {
  final String message;
  final List<String> listMsg;
  final double tp;
  final double tb;
  final int step;
  final bool lamp;
  final double mb;
  final int mt;
  final bool w;
  final bool s;
  final bool a;
  final int timePeriod;
  final int timeNow;
  final bool nextEtap;
  final int whisEtap;
  final bool isWater;

  StateChat({
    this.message = '',
    this.listMsg = const [],
    this.tp = 0,
    this.tb = 0,
    this.step = 0,
    this.lamp = false,
    this.mb = 0,
    this.mt = 0,
    this.w = false,
    this.s = false,
    this.a = false,
    this.timePeriod = 0,
    this.timeNow = 0,
    this.nextEtap = false,
    this.whisEtap = 0,
    this.isWater = false,
  });

  StateChat copyWith({
    String? message,
    List<String>? listMsg,
    double? tp,
    double? tb,
    int? step,
    bool? lamp,
    double? mb,
    int? mt,
    bool? w,
    bool? s,
    bool? a,
    int? timePeriod,
    int? timeNow,
    bool? nextEtap,
    int? whisEtap,
    bool? isWater,
  }) {
    return StateChat(
      message: message ?? this.message,
      listMsg: listMsg ?? this.listMsg,
      tp: tp ?? this.tp,
      tb: tb ?? this.tb,
      step: step ?? this.step,
      lamp: lamp ?? this.lamp,
      mb: mb ?? this.mb,
      mt: mt ?? this.mt,
      w: w ?? this.w,
      s: s ?? this.s,
      a: a ?? this.a,
      timePeriod: timePeriod ?? this.timePeriod,
      timeNow: timeNow ?? this.timeNow,
      nextEtap: nextEtap ?? this.nextEtap,
      whisEtap: whisEtap ?? this.whisEtap,
      isWater: isWater ?? this.isWater,
    );
  }
}

