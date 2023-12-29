import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../app/app.locator.dart';
import 'cognito_service.dart';

class DineseaterApiService {
  final _cognitoService = locator<CognitoService>();
  final String _baseUrl = dotenv.env['DINESEATER_API_URL']!;

}
