class Charater {
 late int charId;
  late String name;
  late String Nickname;
  late List<dynamic> jobs;
  late String image;
  late String actorName;
  late  String CategoryForTwoSearies;
  late String statusOfDeadOrLive;
  late List<dynamic> appearanceOfSeasons;
  late List<dynamic> betteCaulSaulappearance;
  Charater.fromJson(Map<String,dynamic> json)
  {
    charId=json['char_id'];
    name=json['name'];
    Nickname=json['nickname'];
    jobs=json['occupation'];
    image=json['img'];
    actorName=json['portrayed'];
    CategoryForTwoSearies=json['category'];
    statusOfDeadOrLive=json['status'];
    appearanceOfSeasons=json['appearance'];
    betteCaulSaulappearance=json['better_call_saul_appearance'];
  }
}
