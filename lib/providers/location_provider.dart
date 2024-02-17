import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:attendance_app/models/location_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;
  CameraPosition? _kCurrentLocation;

  LocationData? get locationData => _locationData;

  CameraPosition? get currentLocation => _kCurrentLocation;

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _kCurrentLocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
    notifyListeners();
  }

  Future<bool> saveClock(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(Config.clockApiUrl),
        headers: {
          'Authorization':
              'Bearer ${Provider.of<AuthProvider>(context, listen: false).token}',
        },
        body: {
          'latitude': _locationData!.latitude.toString(),
          'longitude': _locationData!.longitude.toString(),
        },
      );
      if (response.statusCode == 200) {
        String message =
            LocationModel.fromJson(jsonDecode(response.body)).message!;
        AnimatedSnackBar.material(message, type: AnimatedSnackBarType.success)
            .show(context);
        return true;
      } else if (response.statusCode == 400) {
        String message =
            LocationModel.fromJson(jsonDecode(response.body)).message!;
        AnimatedSnackBar.material(message, type: AnimatedSnackBarType.error)
            .show(context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
