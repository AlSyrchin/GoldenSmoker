class StateEigth {
  final bool isSettings;
  StateEigth({
    this.isSettings = false,
  });

  StateEigth copyWith({
    bool? isSettings,
  }) {
    return StateEigth(
      isSettings: isSettings ?? this.isSettings,
    );
  }
}
