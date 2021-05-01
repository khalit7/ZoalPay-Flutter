String phoneNumberpattern = r'(^0[19][0-9]{8}$)';
RegExp phoneNumberRegExp = RegExp(phoneNumberpattern);

String ipinPattern = r'(^[0-9]{4}$)';
RegExp ipinRegExp = RegExp(ipinPattern);

String amountPattern = r'(^[0-9]+$)';
RegExp amountRegExp = RegExp(amountPattern);

bool isPhoneNumbervalid(String phoneNumber) {
  return phoneNumberRegExp.hasMatch(phoneNumber);
}

bool isIpinValid(String Ipin) {
  return ipinRegExp.hasMatch(Ipin);
}

bool isAmountValid(String amount) {
  return amountRegExp.hasMatch(amount);
}
