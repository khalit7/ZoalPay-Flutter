class CardModel {
  String cardUserName;
  String cardNumber;
  String expiryDate;
  num id;
  static List<CardModel> allCards = [];
  CardModel({this.cardUserName, this.cardNumber, this.expiryDate, this.id});

  CardModel.fromJson(Map<String, dynamic> json)
      : this.cardUserName = json['name'],
        this.cardNumber = json["pan"],
        this.expiryDate = json["expDate"],
        this.id = json["id"];
}
