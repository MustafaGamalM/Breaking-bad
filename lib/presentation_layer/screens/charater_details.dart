import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic_layer/cubit/character_cubit.dart';
import '../wedgits/widgets.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Charater charater;

  CharacterDetailsScreen({required this.charater});

  Widget builtAppBarSliver() {
    return SliverAppBar(
      backgroundColor: Mycolors.myGrey,
      expandedHeight: 600,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(charater.name),
        background: Hero(
          tag: charater.charId,
          child: Image.network(
            charater.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget CharacterInfo(String job, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: job,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Mycolors.myWhite)),
          TextSpan(
              text: value,
              style: TextStyle(fontSize: 16, color: Mycolors.myWhite)),
        ],
      ),
    );
  }

  Widget MyDivider(double end) {
    return Divider(
      color: Mycolors.myYellow,
      endIndent: end,
      height: 20,
      thickness: 2,
    );
  }

  CheckIfQoutesLoadedOrNot(state) {
    if (state is QoutesLoaded) {
      return displayRandomQouteOrEmptySpace(state);
    } else {
      return ShowLoading();
    }
  }

  Widget displayRandomQouteOrEmptySpace(state) {
    var QoutesOfActor = (state).qoutes;

    if (QoutesOfActor.length != 0) {
      int indexRandom = Random().nextInt(QoutesOfActor.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              color: Mycolors.myYellow,
              shadows: [
                Shadow(
                    blurRadius: 7,
                    offset: Offset(0, 0),
                    color: Mycolors.myYellow)
              ],
              fontSize: 20),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(QoutesOfActor[indexRandom].qoute),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQoutes(charater.name);
    return Scaffold(
      backgroundColor: Mycolors.myGrey,
      body: CustomScrollView(
        slivers: [
          builtAppBarSliver(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  color: Mycolors.myGrey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CharacterInfo('Job : ', charater.jobs.join('/')),
                        MyDivider(315),
                        CharacterInfo('Appeared in : ',
                            charater.appearanceOfSeasons.join('/')),
                        MyDivider(250),
                        CharacterInfo(
                            'Seasons : ', charater.CategoryForTwoSearies),
                        MyDivider(250),
                        CharacterInfo('Status : ', charater.statusOfDeadOrLive),
                        MyDivider(300),
                        (charater.betteCaulSaulappearance.isEmpty)
                            ? Container()
                            : CharacterInfo('Better Call saul Seasons : ',
                                charater.betteCaulSaulappearance.join('/')),
                        (charater.betteCaulSaulappearance.isEmpty)
                            ? Container()
                            : MyDivider(300),
                        CharacterInfo('Actor/Acterss : ', charater.actorName),
                        MyDivider(300),
                        BlocBuilder<CharacterCubit, CharacterState>(
                          builder: (BuildContext context, state) =>
                              CheckIfQoutesLoadedOrNot(state),
                        )
                      ]),
                ),
                SizedBox(
                  height: 600,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
