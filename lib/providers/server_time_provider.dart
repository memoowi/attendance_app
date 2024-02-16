import 'package:attendance_app/models/server_time_model.dart';
import 'package:attendance_app/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ServerTimeProvider extends ChangeNotifier {
  final dio = Dio();
  ServerTimeModel? _serverTime;

  ServerTimeModel? get serverTime => _serverTime;

  Future<void> getServerTime() async {
    try {
      final response = await dio.get(Config.serverTimeApiUrl);
      if (response.statusCode == 200) {
        _serverTime = ServerTimeModel.fromJson(response.data);
        notifyListeners();
      } else {
        throw Exception('Failed to get server time');
      }
    } catch (e) {
      rethrow;
    }
  }
}
