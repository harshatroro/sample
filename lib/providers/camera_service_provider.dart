import 'package:riverpod/riverpod.dart';
import 'package:sample/services/camera_service.dart';

final cameraServiceProvider = StateProvider<CameraService>((ref) => CameraService());