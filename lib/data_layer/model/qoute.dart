class Quote {
  late String qoute;
  Quote.fromJson(Map<String, dynamic> json) {
    qoute = json['quote'];
  }
}
