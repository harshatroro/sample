import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/services/tesseract_service.dart';

final tesseractServiceProvider = StateProvider<TesseractService>((ref) => TesseractService());