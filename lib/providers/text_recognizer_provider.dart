import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textRecognizerProvider = StateProvider<TextRecognizer>((ref) => TextRecognizer(script: TextRecognitionScript.latin));