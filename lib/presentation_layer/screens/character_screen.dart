import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business_logic_layer/cubit/character_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/model/character.dart';
import '../wedgits/widgets.dart';

class CharacterScreen extends StatefulWidget {
  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  bool IsSearched = false;
  late List<Charater> characters;
  late List<Charater> searchedForCharacters;
  TextEditingController searchedController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacter();
  }

  Widget BuildBlocBuilder() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        characters = state.charaters;

        return Container(
          padding: const EdgeInsets.all(10),
          color: Mycolors.myGrey,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: searchedController.text.isEmpty
                  ? characters.length
                  : searchedForCharacters.length,
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 3),
              itemBuilder: (context, index) {
                return CharacterItem(
                    charater: searchedController.text.isEmpty
                        ? characters[index]
                        : searchedForCharacters[index]);
              }),
        );
      } else {
        return ShowLoading();
      }
    });
  }

  Widget searcedBuilder() {
    return TextField(
      controller: searchedController,
      cursorColor: Mycolors.myGrey,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'enter character to search...',
      ),
      onChanged: (String nameOfCharacter) {
        setState(() {
          changeSearchedCharacters(nameOfCharacter);
        });
      },
    );
  }

  void changeSearchedCharacters(String nameOfCharacter) {
    searchedForCharacters = characters.where((searchedCharcater) =>
        searchedCharcater.name
            .toUpperCase()
            .startsWith(nameOfCharacter.toUpperCase())).toList();
  }

  List<Widget> buildAppBarActions(bool issearched) {
    if (issearched) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                issearched = false;
              });
              if (searchedController.text.isEmpty) {
                Navigator.of(context).pop();
              }
              searchedController.clear();
            },
            icon: const Icon(
              Icons.delete,
              color: Mycolors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: startSearch,
            icon: const Icon(
              Icons.search,
              color: Mycolors.myGrey,
            ))
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopsearching));
    setState(() {
      IsSearched = true;
    });
  }

  void stopsearching() {
    searchedController.clear();
    setState(() {
      IsSearched = false;
    });
  }

  Widget textBuilder() {
    return Text(
      'Characters',
      style: TextStyle(color: Mycolors.myGrey),
    );
  }

  Widget buildingNoInternet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 20,
          ),
          const Text(
            'can\'t connect...check internet ',
            style: TextStyle(fontSize: 22, color: Mycolors.myGrey),
          ),
          Image.asset('assets/images/no_internet.png')
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:
              IsSearched ? BackButton(color: Mycolors.myGrey) : Container(),
          actions: buildAppBarActions(IsSearched),
          backgroundColor: Mycolors.myYellow,
          title: IsSearched ? searcedBuilder() : textBuilder()),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return BuildBlocBuilder();
          } else {
            return buildingNoInternet();
          }
        },
        child: ShowLoading(),
      ),
    );
  }
}
