import 'stage.dart';

class StateChoise {
  final List<Recipe> stages;
  final List<Recipe> queryStages;
  final String query;
  final bool isSearch;
  StateChoise({
    required this.stages,
    this.queryStages = const [],
    this.query = '',
    this.isSearch = false,
  });


  StateChoise copyWith({
    List<Recipe>? stages,
    List<Recipe>? queryStages,
    String? query,
    bool? isSearch,
  }) {
    return StateChoise(
      stages: stages ?? this.stages,
      queryStages: queryStages ?? this.queryStages,
      query: query ?? this.query,
      isSearch: isSearch ?? this.isSearch,
    );
  }
}
