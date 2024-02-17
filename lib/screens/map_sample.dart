import 'dart:async';
import 'package:attendance_app/providers/location_provider.dart';
import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapSample extends StatelessWidget {
  MapSample({super.key});
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.759296, -73.985573),
    zoom: 17.0,
  );

  Future<void> _goToCurrentLocation(BuildContext context) async {
    await Provider.of<LocationProvider>(context, listen: false).getLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        Provider.of<LocationProvider>(context, listen: false)
            .currentLocation!));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getLocation();
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () => _goToCurrentLocation(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.tertiaryColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.primaryColor,
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    ),
                    overlayColor: MaterialStateProperty.all<Color>(
                      CustomColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(width: 10.0),
                      const Text('Current Location'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
