import 'dart:convert';

import 'package:dineseater_client_gilson/model/waiting_item_add_request.dart';
import 'package:dineseater_client_gilson/model/waiting_item_post_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../app/app.locator.dart';
import '../model/waiting_item.dart';
import '../model/waiting_list_response.dart';
import 'cognito_service.dart';

import 'package:http/http.dart' as http;

class DineseaterApiService {
  final logger = Logger();
  final _cognitoService = locator<CognitoService>();
  final String _baseUrl = dotenv.env['DINESEATER_API_URL']!;

  Future<List<WaitingItem>> getWaitingList() async {
    logger.i('getWaitingList');
    final token = await _cognitoService.getIdToken();
    final url = Uri.parse('$_baseUrl/business/waitinglist');
    final http.Response response;
    try {
      response = await http.get(url, headers: {'Authorization': token!});
    } catch (e) {
      logger.e('Error while requesting waiting list: $e');
      rethrow;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final waitingListResponse = WaitingListResponse.fromJson(jsonResponse);
      logger.i('getWaitingList success: ${waitingListResponse.message}');
      return waitingListResponse.waitings;
    } else {
      logger.e(
          'Failed to load waiting list with status code: ${response.statusCode}');
      throw Exception('Failed to load waiting list');
    }
  }

  Future<List<WaitingItem>> getWaitingListAfter(DateTime lastModified) async {
    logger.i('getWaitingListAfter');
    final token = await _cognitoService.getIdToken();
    // TODO : change to correct url once API is implemented.
    final url = Uri.parse('$_baseUrl/business/waitinglist');
    final http.Response response;
    try {
      response = await http.get(url, headers: {'Authorization': token!});
    } catch (e) {
      logger.e('Error while requesting waiting list: $e');
      rethrow;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final waitingListResponse = WaitingListResponse.fromJson(jsonResponse);
      logger.i('getWaitingListAfter success: ${waitingListResponse.message}');
      return waitingListResponse.waitings;
    } else {
      logger.e(
          'Failed to load waiting list with status code: ${response.statusCode}');
      throw Exception('Failed to load waiting list');
    }
  }

  Future<WaitingItem> addWaitingItem(
      WaitingItemAddRequest waitingItemPostRequest) async {
    logger.i('PostWaitingItem');
    final token = await _cognitoService.getIdToken();
    final url = Uri.parse('$_baseUrl/business/waitinglist');

    final headers = {
      'Authorization': token!,
    };

    final body = waitingItemPostRequest.toJson();
    final bodyJson = json.encode(body);

    final http.Response response;

    try {
      response = await http.post(url, headers: headers, body: bodyJson);
    } catch (e) {
      logger.e('Error while posting waiting item: $e');
      rethrow;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final waitingItemPostResponse =
          WaitingItemPostResponse.fromJson(jsonResponse);
      logger.i('PostWaitingItem success: ${waitingItemPostResponse.message}');
      return waitingItemPostResponse.waiting;
    } else {
      logger
          .e('Failed to post waiting with status code: ${response.statusCode}');
      throw Exception('Failed to load waiting list');
    }
  }

  // device registration for notification
  Future<void> registerDeviceToken(String deviceToken) async {
    logger.i('registerDeviceToken');
    final token = await _cognitoService.getIdToken();
    final url = Uri.parse('$_baseUrl/business/device_token_registration');
    final http.Response response;
    try {
      response = await http.post(url,
          headers: {'Authorization': token!},
          body: json.encode({'device_token': deviceToken}));
    } catch (e) {
      logger.e('Error while registering device token: $e');
      rethrow;
    }
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      logger.i('registerDeviceToken success: $jsonResponse');
    } else {
      logger.e(
          'Failed to register device token with status code: ${response.statusCode}');
      throw Exception('Failed to register device token');
    }
  }
}
