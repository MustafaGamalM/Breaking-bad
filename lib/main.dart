import 'package:flutter/material.dart';

import 'app_router.dart';
import 'data_layer/web_services/characters_web_services.dart';

void main() {
  charactersWebServices.CharactersWebServices();

  runApp(BreakingBadApp(appRoute: AppRouter()));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRoute;

  const BreakingBadApp({required this.appRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
