// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'stage.dart';

class StateSix {
  final List<Recipe> stages;
  final List<Recipe> queryStages;
  final String query;
  final bool isSearch;
  StateSix({
    required this.stages,
    this.queryStages = const [],
    this.query = '',
    this.isSearch = false,
  });


  StateSix copyWith({
    List<Recipe>? stages,
    List<Recipe>? queryStages,
    String? query,
    bool? isSearch,
  }) {
    return StateSix(
      stages: stages ?? this.stages,
      queryStages: queryStages ?? this.queryStages,
      query: query ?? this.query,
      isSearch: isSearch ?? this.isSearch,
    );
  }
}
