class StateFree {
  final List<bool> btnList;

  StateFree({
    this.btnList = const [true,false,false,false,false,false]
  });

  StateFree copyWith({
    List<bool>? btnList,
  }) {
    return StateFree(
      btnList: btnList ?? this.btnList,
    );
  }
}