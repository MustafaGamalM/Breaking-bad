import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data_layer/model/character.dart';

class CharacterItem extends StatelessWidget {
  final Charater charater;

  CharacterItem({required this.charater});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Mycolors.myWhite),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            CharaterDetailsScreen,
            arguments: charater,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: charater.charId,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                '${charater.name}',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              width: double.infinity,
              color: Colors.black54,
            ),
          ),
          child: Container(
              color: Mycolors.myGrey,
              child: charater.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      imageScale: 1,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: charater.image)
                  : Image.asset('assets/images/mo.jpg')),
        ),
      ),
    );
  }
}

Widget ShowLoading() {
  return Center(
    child: CircularProgressIndicator(
      color: Mycolors.myGrey,
    ),
  );
}
