import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';

void main() async {
  final translator = GoogleTranslator();

  File willTranslateFile = File('will_translate.json');
  File translatedFile = File('translated.json');

  final willTranslateString = await willTranslateFile.readAsString();
  final Map<String, dynamic> willTranslateJson = jsonDecode(willTranslateString);

  Map<String, dynamic> newJson = {};

  int count = 1;
  for (var element in willTranslateJson.entries) {
    try {
      var translation = await translator.translate(element.value, from: 'en', to: 'tr');
      newJson.addAll({element.key: translation.text});
      print('$count : $translation');
    } catch (e) {
      print(e.toString());
    }
    count++;
  }
  final encoded = jsonEncode(newJson);
  await translatedFile.writeAsString(encoded);
}
