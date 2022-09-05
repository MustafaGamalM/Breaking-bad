import '../model/qoute.dart';
import '../web_services/characters_web_services.dart';

import '../model/character.dart';

class CharacterRepository {
  final charactersWebServices CharactersWebServices;

  CharacterRepository(this.CharactersWebServices);
  Future<List<Charater>> getAllCharacter() async {
    final characters = await CharactersWebServices.getAllCharacter();
    return characters.map((e) => Charater.fromJson(e)).toList();
  }

  Future<List<Quote>> getQoutes(String nameActor) async {
    final qoutes = await CharactersWebServices.getQoutes(nameActor);
    return qoutes.map((e) => Quote.fromJson(e)).toList();
  }
}
