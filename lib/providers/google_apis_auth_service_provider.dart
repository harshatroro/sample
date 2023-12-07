import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/services/google_apis_auth_service.dart';

final googleApiAuthServiceProvider = StateProvider<GoogleApisAuthService>((ref) => GoogleApisAuthService());