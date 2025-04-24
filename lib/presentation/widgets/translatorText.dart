import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kite_news/presentation/providers/language_provider.dart';
import 'package:translator/translator.dart';

class TranslatableText extends ConsumerStatefulWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatableText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    
  });

  @override
  ConsumerState<TranslatableText> createState() => _TranslatableTextState();
}

class _TranslatableTextState extends ConsumerState<TranslatableText> {
 // String? translated;
  //final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _translateText());
  }

  // Future<void> _translateText() async {
  //   final lang = ref.read(selectedLanguageProvider);
  //   final result = await translator.translate(widget.data, to: lang);
  //   if (mounted) setState(() => translated = result.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Text(
      //translated ??
       widget.data,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
