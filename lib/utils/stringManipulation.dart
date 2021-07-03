import 'package:basic_utils/basic_utils.dart';

String concealCardNumber(String cardNumber) {
  // it is 16 numbers long
  return cardNumber.substring(0, 7) + "*****" + cardNumber.substring(11);
}

String addSpacesToCardNumber(String cardNumber) {
  return StringUtils.addCharAtPosition(cardNumber, "  ", 4, repeat: true);
}

String beautifyExpiryDate(String expiryDate) {
  return "20" +
      expiryDate[0] +
      expiryDate[1] +
      "/" +
      expiryDate[2] +
      expiryDate[3];
}

String beautifyTransactionAmount(String amount) {
  // example input  => "18293.4"
  String amountWithCommas;
  List splitedAmount = amount.split(".");
  String reversedAmount = splitedAmount[0].split('').reversed.join('');
  String reversedAmountWithCommas =
      StringUtils.addCharAtPosition(reversedAmount, ",", 3, repeat: true);
  amountWithCommas = reversedAmountWithCommas.split('').reversed.join('');
  if (splitedAmount.length == 1)
    return amountWithCommas;
  else
    return amountWithCommas + "." + splitedAmount[1];
}
