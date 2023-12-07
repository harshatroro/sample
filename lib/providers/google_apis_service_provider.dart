import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/providers/google_apis_auth_service_provider.dart';
import 'package:sample/services/google_apis_service.dart';

final googleApisServiceProvider = StateProvider<GoogleApisService>((ref) {
  final googleApiAuthService = ref.read(googleApiAuthServiceProvider.notifier).state;
  return GoogleApisService(
    googleApisAuthService: googleApiAuthService,
  );
});