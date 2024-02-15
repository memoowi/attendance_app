import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60.0,
        leading: Container(
          margin: EdgeInsets.only(left: 15.0),
          alignment: Alignment.center,
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: CustomColors.secondaryColor,
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all<double>(24.0),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.zero,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                CustomColors.tertiaryColor,
              ),
              alignment: Alignment.center,
            ),
          ),
        ),
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      // backgroundColor: CustomColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CustomColors.secondaryColor,
                    CustomColors.tertiaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  colors: [
                    CustomColors.primaryColor,
                    CustomColors.secondaryColor,
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(15.0), // Border width
                decoration: BoxDecoration(
                  color: CustomColors.tertiaryColor, // Border color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Server Time :',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.primaryColor,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 26,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sun, 12 Feb 2024',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 26,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              '5:00 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [
                          CustomColors.tertiaryColor,
                          CustomColors.secondaryColor,
                          CustomColors.primaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.3, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.primaryColor.withOpacity(0.5),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.clock_fill, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        'Clock In / Out',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
