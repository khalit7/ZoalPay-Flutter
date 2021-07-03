class PayeeModel {
  String payeeName;
  String payeeId;
  num id;
  static List<PayeeModel> allPayees = [];
  PayeeModel({this.payeeName, this.payeeId, this.id});

  @override
  String toString() {
    return '{"payeeName":"$payeeName","payeeId":"$payeeId","id":$id}';
  }

  PayeeModel.fromJson(Map<String, dynamic> json)
      : this.payeeName = json['payeeName'],
        this.payeeId = json["payeeId"],
        this.id = json["id"];
}

PayeeModel zainTopUpPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "Zain Top Up");

PayeeModel mtnTopUpPayeeModel =
    PayeeModel.allPayees.firstWhere((payee) => payee.payeeName == "MTN Top Up");

PayeeModel sudaniTopUpPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "Sudani Top Up");

PayeeModel zainBillPaymentPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "Zain Bill Payment");

PayeeModel mtnBillPaymentPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "MTN Bill Payment");

PayeeModel sudaniBillPaymentPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "SUDANI Bill Payment");

PayeeModel electricityPayeeModel = PayeeModel.allPayees
    .firstWhere((payee) => payee.payeeName == "National Electricity Corp.");

PayeeModel dalPayeeModel =
    PayeeModel.allPayees.firstWhere((payee) => payee.payeeName == "Dal Biller");

PayeeModel e15PayeeModel =
    PayeeModel.allPayees.firstWhere((payee) => payee.payeeName == "E15");
