import 'dart:convert';
import 'package:attendance_app/models/attendance_list_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AttendanceListProvider extends ChangeNotifier {
  AttendanceListModel? _attendances;

  AttendanceListModel? get attendances => _attendances;

  Future<void> getAttendances(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(Config.attendanceApiUrl),
        headers: {
          'Authorization':
              'Bearer ${Provider.of<AuthProvider>(context, listen: false).token}',
        },
      );

      if (response.statusCode == 200) {
        _attendances = AttendanceListModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to get attendances');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshAttendancesList(BuildContext context) async {
    _attendances = null;
    notifyListeners();
    await getAttendances(context);
  }
}
