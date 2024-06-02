import 'package:attendance_app/providers/location_provider.dart';
import 'package:attendance_app/providers/server_time_provider.dart';
import 'package:attendance_app/screens/map_sample.dart';
import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({super.key});

  void _clock(BuildContext context) async {
    await Provider.of<LocationProvider>(context, listen: false)
        .saveClock(context)
        .then((value) {
      if (value == true) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CustomColors.secondaryColor,
                    CustomColors.tertiaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: MapSample(),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  colors: [
                    CustomColors.primaryColor,
                    CustomColors.secondaryColor,
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(15.0), // Border width
                decoration: BoxDecoration(
                  color: CustomColors.tertiaryColor, // Border color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Server Time :',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.primaryColor,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Consumer(
                      builder: (context, ServerTimeProvider serverTime, child) {
                        if (serverTime.serverTime == null) {
                          return const Text('Loading...');
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    DateFormat("EEE, d MMM yyyy").format(
                                      serverTime.serverTime!.data!.date!,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    DateFormat("h:mm a").format(
                                      serverTime.serverTime!.data!.date!,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
                builder: (context, LocationProvider locationProvider, child) {
              if (locationProvider.locationData == null) {
                return clockButton(context, false);
              } else {
                return clockButton(context, true);
              }
            }),
            const SizedBox(height: 20.0),
            const Text(
              'Current Location :',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColors.primaryColor,
                fontSize: 14.0,
              ),
            ),
            Consumer(
              builder: (context, LocationProvider locationProvider, child) {
                if (locationProvider.locationData == null) {
                  return const Text('Loading...');
                } else {
                  return Text(
                    '${locationProvider.locationData!.latitude}, ${locationProvider.locationData!.longitude}',
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  BackButton backButton(BuildContext context) {
    return BackButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: CustomColors.secondaryColor,
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all<double>(24.0),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.zero,
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          CustomColors.tertiaryColor,
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Stack clockButton(BuildContext context, bool isEnabled) {
    {
      return Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: isEnabled
                    ? const LinearGradient(
                        colors: [
                          CustomColors.tertiaryColor,
                          CustomColors.secondaryColor,
                          CustomColors.primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.3, 1.0],
                      )
                    : const LinearGradient(colors: [
                        CustomColors.tertiaryColor,
                        CustomColors.tertiaryColor,
                      ]),
                boxShadow: [
                  isEnabled
                      ? BoxShadow(
                          color: CustomColors.primaryColor.withOpacity(0.5),
                          blurRadius: 6.0,
                        )
                      : const BoxShadow(color: Colors.transparent),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (isEnabled == true) {
                _clock(context);
              } else {
                null;
              }
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.transparent),
              foregroundColor: WidgetStateProperty.all<Color>(
                isEnabled
                    ? Colors.white
                    : CustomColors.primaryColor.withOpacity(0.4),
              ),
              overlayColor: WidgetStateProperty.all<Color>(
                isEnabled ? CustomColors.secondaryColor : Colors.transparent,
              ),
              elevation: WidgetStateProperty.all<double>(0),
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.clock_fill),
                SizedBox(width: 10.0),
                Text(
                  'Clock In / Out',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
