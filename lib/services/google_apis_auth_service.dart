import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleApisAuthService {
  Future<ServiceAccountCredentials> loadServiceAccountCredentials() async {
    await dotenv.load(fileName: '.env');
    final email = dotenv.env['CLIENT_EMAIL'];
    final id = dotenv.env['CLIENT_ID'];
    final privateKey = dotenv.env['PRIVATE_KEY'];
    final clientId = ClientId(id!);
    return ServiceAccountCredentials(email!, clientId, privateKey!);
  }
}