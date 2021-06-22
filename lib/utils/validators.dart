String phoneNumberpattern = r'(^0[19][0-9]{8}$)';
RegExp phoneNumberRegExp = RegExp(phoneNumberpattern);

String ipinPattern = r'(^[0-9]{4}$)';
RegExp ipinRegExp = RegExp(ipinPattern);

String amountPattern = r'(^[0-9]+$)';
RegExp amountRegExp = RegExp(amountPattern);

String cardNumberPattern = r'(^[0-9]{16}$)';
RegExp cardNumberRegExp = RegExp(cardNumberPattern);

String meterNumberPattern = r'(^[0-9]{11}$)';
RegExp meterNumberRegExp = RegExp(meterNumberPattern);

String expiryDatePattern = r'(^[0-9]{4}$)';
RegExp expiryDateRegExp = RegExp(expiryDatePattern);

bool isPhoneNumbervalid(String phoneNumber) {
  return phoneNumberRegExp.hasMatch(phoneNumber);
}

bool isIpinValid(String Ipin) {
  return ipinRegExp.hasMatch(Ipin);
}

bool isAmountValid(String amount) {
  return amountRegExp.hasMatch(amount);
}

bool isCardNumberValid(String cardNumber) {
  return cardNumberRegExp.hasMatch(cardNumber);
}

bool isMeterNumberValid(String meterNumber) {
  return meterNumberRegExp.hasMatch(meterNumber);
}

bool isExpiryDateValid(String expiryDate) {
  return expiryDateRegExp.hasMatch(expiryDate);
}

/////////////

String phoneNumbervalidError(String phoneNumber) {
  if (isPhoneNumbervalid(phoneNumber))
    return null; // card number valid
  else
    return "Phone number invalid"; // the error message
}

String iPinValidError(String Ipin) {
  if (isIpinValid(Ipin))
    return null; // card number valid
  else
    return "IPIN is not valid, it should consist of 4 numbers"; // the error message
}

String amountValidError(String amount) {
  if (isAmountValid(amount))
    return null; // card number valid
  else
    return "Amount is not valid"; // the error message
}

String cardNumberValidError(String cardNumber) {
  if (isCardNumberValid(cardNumber))
    return null; // card number valid
  else
    return "Card number should consist of 16 numbers"; // the error message
}

String meterNumberValidError(String meterNumber) {
  if (isMeterNumberValid(meterNumber))
    return null; // card number valid
  else
    return "Please enter a valid meter number"; // the error message
}

String expiryDateValidError(String expiryDate) {
  if (isExpiryDateValid(expiryDate))
    return null; // expiry Date valid
  else
    return "Expiry date should be in the form yy/mm eg: 2401 "; // the error message
}
