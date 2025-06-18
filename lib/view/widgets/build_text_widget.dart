import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class BuildTextWidget extends StatefulWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? toLang;
  final String? fromLang;
  final bool? softWrap;
  final TextOverflow? overflow;
  final Function(String)? onTranslated;

  const BuildTextWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.size = 14.0,
    this.fontWeight = FontWeight.normal,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.toLang,
    this.fromLang,
    this.softWrap,
    this.overflow,
    this.onTranslated,
  }) : super(key: key);

  @override
  _BuildTextWidgetState createState() => _BuildTextWidgetState();
}

class _BuildTextWidgetState extends State<BuildTextWidget> {
  String? translatedText;
  bool _isTranslating = false;

  @override
  void initState() {
    super.initState();
    _translate(widget.text, widget.fromLang, widget.toLang);
  }

  @override
  void didUpdateWidget(covariant BuildTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.fromLang != widget.fromLang ||
        oldWidget.toLang != widget.toLang) {
      _translate(widget.text, widget.fromLang, widget.toLang);
    }
  }

  Future<void> _translate(String text, String? fromLang, String? toLang) async {
    if (toLang == null || toLang.isEmpty) {
      setState(() {
        translatedText = text;
      });
      return;
    }

    setState(() {
      _isTranslating = true;
    });

    try {
      final translator = GoogleTranslator();
      final translation = await translator.translate(
        text,
        from: fromLang ?? 'auto',
        to: toLang,
      );

      if (!mounted) return;

      setState(() {
        translatedText = translation.text;
        _isTranslating = false;
      });

      widget.onTranslated?.call(translation.text);
    } catch (e) {
      print("Translation error: $e");
      if (!mounted) return;

      setState(() {
        translatedText = text;
        _isTranslating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isTranslating || translatedText == null) {
      return const SizedBox();
    }
    return Text(
      translatedText!,
      maxLines: widget.maxLines,
      softWrap: widget.softWrap ?? true,
      overflow: widget.overflow ?? TextOverflow.clip,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
