//Выполняем логику, получаем данные.

import 'package:bloc/bloc.dart';
import 'etap.dart';
import 'repository.dart';
part 'state.dart';


class RecipeCubit extends Cubit<ReciepState> {
  final ListState _etapRepository;

  RecipeCubit(this._etapRepository) : super(const RecLoaded([]));

  void getEtap() {
    try {
      emit(const RecLoading());
      final list = _etapRepository.stage;
      emit(RecLoaded(list));
    } on NetworkException {
      emit(const RecError("Couldn't fetch weather. Is the device online?"));
    }
  }

    void addEtap() {
      final list = _etapRepository.addStage(Frying(5, 5));
      emit(RecLoaded(list));
  }

      void removeEtap(int index) {
      final list = _etapRepository.removeStage(index);
      emit(RecLoaded(list));
  }
}