import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:riverpod/riverpod.dart';

final textRecognizerProvider = StateProvider<TextRecognizer>((ref) => TextRecognizer(script: TextRecognitionScript.latin));