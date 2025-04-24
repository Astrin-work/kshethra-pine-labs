import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorTextWidget extends StatelessWidget {
  const TranslatorTextWidget({super.key});

  Future<String> _translateText(String text) async {
    final translator = GoogleTranslator();
    try {
      var translation = await translator.translate(text, to: 'ml');
      return translation.text;
    } catch (e) {
      print("Translation error: $e");
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Translation Test")),
      body: Center(
        child: FutureBuilder<String>(
          future: _translateText("Name"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text("Error translating");
            }
            return Text(
              snapshot.data ?? "Name",
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
