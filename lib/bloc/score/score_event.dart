part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent {}

class LoadScoreEvent extends ScoreEvent {}

class ScoreLoadedEvent extends ScoreEvent {}
