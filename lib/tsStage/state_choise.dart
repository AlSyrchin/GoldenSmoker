import 'stage.dart';

class StateChoise {
  final List<Recipe> stages;
  final List<Recipe> queryStages;
  final String query;
  final bool isSearch;
  final List<bool> btnGrid;
  StateChoise({
    required this.stages,
    this.queryStages = const [],
    this.query = '',
    this.isSearch = false,
    this.btnGrid = const [true,false],
  });

  StateChoise copyWith({
    List<Recipe>? stages,
    List<Recipe>? queryStages,
    String? query,
    bool? isSearch,
    List<bool>? btnGrid,
  }) {
    return StateChoise(
      stages: stages ?? this.stages,
      queryStages: queryStages ?? this.queryStages,
      query: query ?? this.query,
      isSearch: isSearch ?? this.isSearch,
      btnGrid: btnGrid ?? this.btnGrid,
    );
  }
}
