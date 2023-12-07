import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class GoogleMLKitTextRecognitionService {
  final TextRecognizer textRecognizer;

  GoogleMLKitTextRecognitionService({
    required this.textRecognizer,
  });

  Future<String> readTextFromImage(String path) async {
    InputImage inputImage = InputImage.fromFilePath(path);
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }
}