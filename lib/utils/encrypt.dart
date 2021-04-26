import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncrypterUtil {
  static String encrypt(String input, String key) {
    String formatedKey = _splitStr(key);
    final encrypter = Encrypter(RSA(
        publicKey: RSAKeyParser().parse("$formatedKey"),
        encoding: RSAEncoding.PKCS1));

    return encrypter.encrypt(input).base64;
  }

  static _splitStr(String str) {
    var begin = '-----BEGIN PUBLIC KEY-----\n';
    var end = '\n-----END PUBLIC KEY-----';
    int splitCount = str.length ~/ 64;
    List<String> strList = List();

    for (int i = 0; i < splitCount; i++) {
      strList.add(str.substring(64 * i, 64 * (i + 1)));
    }
    if (str.length % 64 != 0) {
      strList.add(str.substring(64 * splitCount));
    }

    return begin + strList.join('\n') + end;
  }
}
