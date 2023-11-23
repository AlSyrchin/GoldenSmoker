// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'stage.dart';

class StateOne {
  final List<Stage> stage;
  final String name;
  StateOne({
    this.stage = const [],
    this.name = '',
  });


  StateOne copyWith({
    List<Stage>? stage,
    String? name,
  }) {
    return StateOne(
      stage: stage ?? this.stage,
      name: name ?? this.name,
    );
  }
}
