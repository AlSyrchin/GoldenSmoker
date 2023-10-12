// Описываем состояния. Первоночальный этап.

part of 'cubit.dart';

abstract class ReciepState {
  const ReciepState();
}

// Состояние инициализации
class RecInitial extends ReciepState {
  const RecInitial();
}

class RecLoading extends ReciepState {
  const RecLoading();
}

class RecLoaded extends ReciepState {
  final List<Stage> list;
  const RecLoaded(this.list);

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is RecLoaded && o.list == list;
  // }

  @override
  int get hashCode => list.hashCode;
}

class RecError extends ReciepState {
  final String message;
  const RecError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
