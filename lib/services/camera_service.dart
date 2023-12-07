import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  CameraDescription? camera;
  CameraController? cameraController;
  PermissionStatus? cameraPermission;

  Future<CameraDescription> getCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.first;
  }

  Future<PermissionStatus> getCameraPermission() async {
    return await Permission.camera.status;
  }

  Future<CameraController?> getCameraController() async {
    cameraPermission ??= await getCameraPermission();
    if (cameraPermission! == PermissionStatus.granted) {
      camera ??= await getCamera();
      CameraController temporaryController = CameraController(camera!, ResolutionPreset.max);
      await temporaryController.initialize().then((value) => value);
      return temporaryController;
    } else if (cameraPermission! == PermissionStatus.denied) {
      await Permission.camera.request();
      return getCameraController();
    } else if (cameraPermission! == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return null;
    }
    return null;
  }

  Future<XFile?> takePicture() async {
    cameraController ??= await getCameraController();
    if(cameraController != null) {
      XFile image = await cameraController!.takePicture();
      return image;
    } else {
      return null;
    }
  }
}