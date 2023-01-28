import 'package:bloc/bloc.dart';
import 'package:memorize/data/score_repository.dart';
import 'package:memorize/models/score.dart';
import 'package:meta/meta.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  ScoreRepository scoreRepository;
  AppLocalizations localizer;
  GameBloc(this.scoreRepository, this.localizer) : super(GameInitial()) {
    on<StartGameEvent>((event, emit) {
      emit(GameStarted());
    });
    on<EndGameEvent>((event, emit) async {
      String username = event.username;
      int score = event.score;
      Score newScore = Score(username: username, score: score);
      List<Score> scores = await scoreRepository.find(username);
      bool scoreNotFound = scores.isEmpty;
      if (scoreNotFound || score < scores.elementAt(0).score) {
        await scoreRepository.add(newScore);
      }
      emit(GameEnded());
    });
    on<ReStartGameEvent>((event, emit) {
      emit(GameStarted());
    });
  }
}
