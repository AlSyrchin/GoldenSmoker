import 'package:flutter/material.dart';

class StateSeven {
  final int activePage;
  final double tbox;
  final double tprod;
  final int time;
  final bool lamp;
  PageController pageController = PageController(viewportFraction: 0.6);
  StateSeven({
    this.activePage = 0,
    this.tbox = 0,
    this.tprod = 0,
    this.time = 0,
    this.lamp = false,
  });

  StateSeven copyWith({
    int? activePage,
    double? tbox,
    double? tprod,
    int? time,
    bool? lamp
  }) {
    return StateSeven(
      activePage: activePage ?? this.activePage,
      tbox: tbox ?? this.tbox,
      tprod: tprod ?? this.tprod,
      time: time ?? this.time,
      lamp: lamp ?? this.lamp,
    );
  }
}
