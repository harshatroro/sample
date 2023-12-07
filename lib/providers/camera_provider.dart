import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/providers/camera_service_provider.dart';

final cameraProvider = FutureProvider<CameraController?>((ref) async {
  final cameraService = ref.read(cameraServiceProvider.notifier).state;
  final cameraController = await cameraService.getCameraController();
  return cameraController;
});