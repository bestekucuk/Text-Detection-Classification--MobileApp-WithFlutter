import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exam/utils/models/api_models.dart';
import 'package:flutter_exam/utils/services/api_service.dart';

class FirstPage extends StatefulWidget {
  final String? scannedText;
  const FirstPage({Key? key, this.scannedText}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController textController1 = TextEditingController();
  // final TextEditingController textController2 = TextEditingController();
  String defaultText = "Category";
  late String ext = ''; // Başlangıç metni

  Future<void> text() async {
    ext = await widget.scannedText ?? "";
    print(ext);
  }

  @override
  void initState() {
    super.initState();

    // Diğer sayfadan gelen metni burada alabilirsiniz
    text();
    if (ext.isNotEmpty) {
      print('ext mevcut');
      print(ext);
    }
  }

  void updateText(String defaultText) {
    setState(() {
      // Yeni metni burada ayarlayabilirsiniz
      this.defaultText = defaultText;
    });
  }

  APIService apiService = APIService();
  // Başlangıçta varsayılan metin değeri
  String category = '';
  @override
  Widget build(BuildContext context) {
    // APIService apiService = APIService();
    // apiService.getText();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Text Classification',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 163, 185),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 215, 204, 218)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                height: 150.0,
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: textController1,
                  decoration: InputDecoration(
                    hintText:
                        widget.scannedText ?? 'Enter your first text here',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    hintMaxLines: 10,
                  ),
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  sendData();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: const Color.fromARGB(255, 191, 184, 192),
                ),
                child: const Text("Let's Predict with FFN"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 195, 207),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 215, 204, 218)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  defaultText,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Assuming you have a Text widget to display the category property
  late String categoryText;

  Future<void> sendData() async {
    TextModel model =
        TextModel(text: widget.scannedText ?? textController1.text);
    final resp = await apiService.postText(model);

    if (resp.statusCode == HttpStatus.ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully created"),
        ),
      );

      // Update the categoryText with the category property from the response
      categoryText = apiService.updateCategoryText(resp);
      print(categoryText);
      updateText(categoryText);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create"),
        ),
      );
    }
    print(textController1.text.toString());
    print(resp.statusCode);
    print(resp.body);
  }
}
