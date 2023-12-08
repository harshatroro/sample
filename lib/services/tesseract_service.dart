import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class TesseractService {
  String selectedLanguage = 'eng';

  Future<String> readTextFromImage(String imagePath) async {
    return await FlutterTesseractOcr.extractText(
      imagePath,
      language: selectedLanguage,
      args: {
        "preserve_interword_spaces": "1",
      },
    );
  }
}