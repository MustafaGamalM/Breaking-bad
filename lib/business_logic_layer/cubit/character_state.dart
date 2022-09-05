part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Charater> charaters;

  CharacterLoaded(this.charaters);
}

class QoutesLoaded extends CharacterState {
  final List<Quote> qoutes;

  QoutesLoaded(this.qoutes);
}
