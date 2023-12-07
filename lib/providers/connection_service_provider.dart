import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/services/connection_service.dart';

final connectionServiceProvider = StateProvider<ConnectionService>((ref) => ConnectionService());