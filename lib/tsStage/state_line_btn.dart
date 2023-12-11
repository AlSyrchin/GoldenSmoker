class StateLineBTN {
  final List<bool> btnList;

  StateLineBTN({
    this.btnList = const [true,false,false,false,false,false]
  });

  StateLineBTN copyWith({
    List<bool>? btnList,
  }) {
    return StateLineBTN(
      btnList: btnList ?? this.btnList,
    );
  }
}