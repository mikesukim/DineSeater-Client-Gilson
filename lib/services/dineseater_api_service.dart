import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../app/app.locator.dart';
import '../model/waiting_list_response.dart';
import 'cognito_service.dart';

import 'package:http/http.dart' as http;

class DineseaterApiService {
  final logger = Logger();
  final _cognitoService = locator<CognitoService>();
  final String _baseUrl = dotenv.env['DINESEATER_API_URL']!;

  Future<WaitingListResponse> getWaitingList() async {
    final token = await _cognitoService.getIdToken();
    final url = Uri.parse('$_baseUrl/business/waitinglist');
    final response = await http.get(url, headers: {'Authorization': token!});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return WaitingListResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load waiting list');
    }
  }
}