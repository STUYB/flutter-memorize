part of 'score_bloc.dart';

@immutable
abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class ScoreLoadedState extends ScoreState {
  final List<Score> scores;
  ScoreLoadedState({required this.scores});
}
