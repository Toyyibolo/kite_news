
import 'package:translator/translator.dart';

Future<String> autoTranslate(String text, String langCode) async {
  final translator = GoogleTranslator();
  return (await translator.translate(text, to: langCode)).text;
}
