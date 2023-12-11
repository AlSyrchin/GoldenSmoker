class StateCreater {
  final bool isSettings;
  StateCreater({
    this.isSettings = false,
  });

  StateCreater copyWith({
    bool? isSettings,
  }) {
    return StateCreater(
      isSettings: isSettings ?? this.isSettings,
    );
  }
}
