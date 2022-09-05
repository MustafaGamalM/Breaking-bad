import 'package:bloc/bloc.dart';
import '../../data_layer/model/character.dart';
import '../../data_layer/model/qoute.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  List<Charater> Chars = [];
  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  List<Charater> getAllCharacter() {
    characterRepository.getAllCharacter().then((characters) {
      emit(CharacterLoaded(characters));
      Chars = characters;
    });
    return Chars;
  }

  getQoutes(String nameActor) {
    characterRepository.getQoutes(nameActor).then((Qoutes) {
      emit(QoutesLoaded(Qoutes));
    });
  }
}
