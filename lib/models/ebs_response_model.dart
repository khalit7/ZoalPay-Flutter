class EbsResponseModel {
  int transactionFee;
  String fromAccount;
  bool responseStatus;
  int responseCode;
  String responseMessage;
  int transactionAmount;
  num balance;
  String pan;
  String paymentInfo;
  String voucherCode;
  String reciverCard;
  String customerName;
  String token;
  String unitsInKWh;
  String meterNumber;
  String waterFees;

  EbsResponseModel.fromJson(Map<String, dynamic> json)
      : this.transactionFee = json['acqTranFee'],
        this.fromAccount = json['fromAccount'],
        this.responseStatus = json['responseStatus'] == "Failed" ? false : true,
        this.responseCode = json['responseCode'],
        this.responseMessage = json['responseMessage'],
        this.transactionAmount = json['tranAmount'],
        this.balance =
            json["balance"] == null ? null : json["balance"]["available"],
        this.pan = json['PAN'],
        this.paymentInfo = json['paymentInfo'],
        this.voucherCode = json['voucherCode'],
        this.reciverCard = json['toCard'],
        this.customerName =
            json['billInfo'] == null ? null : json['billInfo']['customerName'],
        this.token =
            json['billInfo'] == null ? null : json['billInfo']['token'],
        this.unitsInKWh =
            json['billInfo'] == null ? null : json['billInfo']['unitsInKWh'],
        this.meterNumber =
            json['billInfo'] == null ? null : json['billInfo']['meterNumber'],
        this.waterFees =
            json['billInfo'] == null ? null : json['billInfo']['waterFees'];
}

/*
{\"tranDateTime\":\"110621100428\"
,\"acqTranFee\":5
,\"dynamicFees\":0,
\"tranCurrency\":\"SDG\"
,\"fromAccount\":\"?\",
\"accountCurrency\":null,
\"responseStatus\":\"Failed\",
\"expDate\":\"2501\",
\"responseCode\":74,
\"fromAccountType\":\"00\",
\"balance\":null,
\"billInfo\":{},
\"issuerTranFee\":0,
\"authenticationType\":\"00\",
\"payeeId\":\"0010020001\",
\"PAN\":\"639257*****7881\",
\"UUID\":\"2cb73ca0-caf0-11eb-9b04-d9398382413b\",
\"applicationId\":\"ZoalPay\",
\"responseMessage\":\"Format error\",
\"tranAmount\":100,
\"mbr\":\"0\",
\"paymentInfo\":\"METER=\"
}"
*/
