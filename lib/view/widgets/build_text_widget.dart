  import 'package:flutter/material.dart';
  import 'package:translator/translator.dart';

  class BuildTextWidget extends StatefulWidget {
    final String text;
    final Color? color;
    final double? size;
    final FontWeight? fontWeight;
    final int? maxLines;
    final TextAlign? textAlign;
    final String toLang;
    final Function(String)? onTranslated;

    const BuildTextWidget({
      Key? key,
      required this.text,
      this.color = Colors.black,
      this.size = 14.0,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 1,
      this.textAlign = TextAlign.left,
      required this.toLang,
      this.onTranslated,
    }) : super(key: key);

    @override
    _BuildTextWidgetState createState() => _BuildTextWidgetState();
  }

  class _BuildTextWidgetState extends State<BuildTextWidget> {
    String? translatedText;

    @override
    void initState() {
      super.initState();
      _translate(widget.text, widget.toLang);
    }

    @override
    void didUpdateWidget(covariant BuildTextWidget oldWidget) {
      super.didUpdateWidget(oldWidget);
      if (oldWidget.toLang != widget.toLang || oldWidget.text != widget.text) {
        _translate(widget.text, widget.toLang);
      }
    }

    Future<void> _translate(String text, String toLang) async {
      try {
        final translator = GoogleTranslator();
        final translation = await translator.translate(text, to: toLang);

        if (!mounted) return;

        setState(() {
          translatedText = translation.text;
        });

        if (widget.onTranslated != null) {
          widget.onTranslated!(translation.text);
        }
      } catch (e) {
        print("Translation error: $e");
      }
    }

    @override
    Widget build(BuildContext context) {
      if (translatedText == null) {
        return const SizedBox();
      }
      return Text(
        translatedText!,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign,
        style: TextStyle(
          color: widget.color,
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
        ),
      );
    }
  }
