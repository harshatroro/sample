import 'dart:convert';
import 'dart:io';

import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:sample/services/google_apis_auth_service.dart';

class GoogleApisService {
  GoogleApisService({
    required this.googleApisAuthService,
  });

  GoogleApisAuthService googleApisAuthService;
  AutoRefreshingAuthClient? client;
  ServiceAccountCredentials? serviceAccountCredentials;
  VisionApi? visionApi;

  Future<ServiceAccountCredentials> getServiceAccountCredentials() async {
    return await googleApisAuthService.loadServiceAccountCredentials();
  }

  Future<VisionApi> getVisionApi() async {
    serviceAccountCredentials ??= await getServiceAccountCredentials();
    final scopes = [VisionApi.cloudVisionScope];
    client = await clientViaServiceAccount(serviceAccountCredentials!, scopes);
    return VisionApi(client!);
  }

  Future<String> getBase64Image(String path) async {
    List<int> imageInBytes = await File(path).readAsBytes();
    return base64Encode(imageInBytes);
  }

  Future<String?> readTextFromImage(String path) async {
    String image = await getBase64Image(path);
    visionApi ??= await getVisionApi();
    BatchAnnotateImagesRequest request = BatchAnnotateImagesRequest.fromJson({
      "requests": [
        {
          "image": {
            "content": image,
          },
          "features": [
            {
              "type": "TEXT_DETECTION",
            },
          ],
        },
      ],
    });
    final response = await visionApi!.images.annotate(request);
    if (response.responses != null && response.responses!.isNotEmpty) {
      final textAnnotations = response.responses![0].textAnnotations;
      if (textAnnotations != null && textAnnotations.isNotEmpty) {
        return textAnnotations[0].description;
      }
    }
    return null;
  }
}