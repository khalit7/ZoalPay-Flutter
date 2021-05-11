String concealCardNumber(String cardNumber) {
  // it is 16 numbers long
  return cardNumber.substring(0, 7) + "*****" + cardNumber.substring(11);
}
