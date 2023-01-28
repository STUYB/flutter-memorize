import 'package:bloc/bloc.dart';
import 'package:memorize/data/score_repository.dart';
import 'package:memorize/models/score.dart';
import 'package:meta/meta.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreRepository scoreRepository;
  ScoreBloc(this.scoreRepository) : super(ScoreInitial()) {
    on<LoadScoreEvent>((event, emit) async {
      var scores = await scoreRepository.getAll();
      scores.sort((a, b) => a.score.compareTo(b.score));
      emit(ScoreLoadedState(scores: scores));
    });
  }
}
