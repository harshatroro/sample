import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/providers/camera_provider.dart';
import 'package:sample/providers/camera_service_provider.dart';
import 'package:sample/providers/connection_service_provider.dart';
import 'package:sample/providers/google_ml_kit_text_recognition_service_provider.dart';
import 'package:sample/screens/result_screen.dart';
import 'package:sample/widgets/alert_dialog.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    final camera = ref.watch(cameraProvider.future);
    final cameraService = ref.watch(cameraServiceProvider.notifier).state;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: FutureBuilder<CameraController?>(
          future: camera,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data == null) {
                return const Center(
                  child: Text("Permission Denied."),
                );
              }
              return Stack(
                children: [
                  CameraPreview(snapshot.data!),
                  Positioned(
                    bottom: 50,
                    left: (MediaQuery.of(context).size.width / 2) - 25,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(50),
                      padding: const EdgeInsets.all(16),
                      color: processing ? CupertinoColors.inactiveGray : CupertinoColors.activeBlue,
                      onPressed: !processing
                          ? () async {
                        setState(() {
                          processing = true;
                        });
                        final connectionService = ref.read(connectionServiceProvider.notifier).state;
                        final connectionResult = await connectionService.checkConnected();
                        if(connectionResult) {
                          // XFile? capturedImage = await cameraService.takePicture();
                          File capturedImage = File('lib/IMG_2864.jpg');
                          final processor = ref.read(googleMLKitTextRecognitionServiceProvider.notifier).state;
                          final textInImage = await processor.readTextFromImage(capturedImage!.path);
                          setState(() {
                            processing = true;
                          });
                          debugPrint("Text Captured: $textInImage");
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ResultScreen(text: "$textInImage")
                              )
                          );
                        } else {
                          setState(() {
                            processing = true;
                          });
                          // ignore: use_build_context_synchronously
                          showCupertinoDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                  title: "No Internet Connection",
                                  content: "Please connect to the internet to scan the card",
                                  actionText: "OK"
                              )
                          );
                        }
                      }
                      : null,
                      child: const Icon(
                        CupertinoIcons.camera,
                        color: CupertinoColors.white,
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
