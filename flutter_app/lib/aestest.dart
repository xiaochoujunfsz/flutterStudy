import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

void main() {
  final encrypt_str_16 =
      "958e37f2137787080c339edb2117c5085ada8659f0d5efa49cc1252c2e7b71e8f7e205d7af56c76b507a41bad1bd73d2100a5725cc628739b9dabe8c1a107b44a55411f38e874be0667507c05fc25749";
  final key = Key.fromUtf8('083e5410e216c18cb51b034135cba97b');
  final iv = IV.fromUtf8("e216c18cb51b0341");

  List<int> base64Int = [];
  for (int i = 0; i < encrypt_str_16.length / 2; i++) {
    base64Int.add(int.parse(encrypt_str_16.substring(i * 2,i * 2 + 2),radix: 16));
  }
  String result = base64.encode(base64Int);

  print(result);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

  final decrypted = encrypter.decrypt64(result, iv: iv);

  print(decrypted);
}

String hex2base64(String hex) {
  if (hex.length % 2 != 0) {
    return null;
  }
  String base64String = '';
  try {
    for (int i = 0; i < hex.length / 2; i++) {
      int code = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
      base64String += String.fromCharCode(code);
    }
    String str = '';
    Uint8List result = base64.decode(base64String);
    result.forEach((int v) {
      str += String.fromCharCode(v);
    });
    return str;
  } catch (err) {
    return null;
  }
}
