import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/providers/text_recognizer_provider.dart';
import 'package:sample/services/google_ml_kit_text_recognition_service.dart';

final googleMLKitTextRecognitionServiceProvider = StateProvider<GoogleMLKitTextRecognitionService>((ref) {
  final textRecognizer = ref.read(textRecognizerProvider.notifier).state;
  return GoogleMLKitTextRecognitionService(
    textRecognizer: textRecognizer,
  );
});