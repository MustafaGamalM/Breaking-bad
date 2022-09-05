import 'constants/strings.dart';
import 'data_layer/model/character.dart';
import 'data_layer/repository/character_repository.dart';
import 'presentation_layer/screens/character_screen.dart';
import 'presentation_layer/screens/charater_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic_layer/cubit/character_cubit.dart';
import 'data_layer/web_services/characters_web_services.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;
  AppRouter() {
    characterRepository = CharacterRepository(charactersWebServices());
    characterCubit = CharacterCubit(characterRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharaterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharacterCubit(characterRepository),
                  child: CharacterScreen(),
                ));
      case CharaterDetailsScreen:
        final character = settings.arguments as Charater;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CharacterCubit(characterRepository),
                  child: CharacterDetailsScreen(charater: character),
                ));
    }
  }
}
