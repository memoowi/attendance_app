import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Welcome, ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          CustomColors.primaryColor,
                          CustomColors.secondaryColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Misbach !',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      CustomColors.primaryColor,
                      CustomColors.secondaryColor,
                    ],
                    center: Alignment.topRight,
                    radius: 4.5,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Server Time :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Asia/Jakarta',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.refresh_sharp),
                              color: Colors.white,
                              iconSize: 16.0,
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(5.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mon, 12 Feb 2024',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            '9:30 AM',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Here are your latest attendances',
              ),
              SizedBox(height: 20.0),
              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: CustomColors.tertiaryColor,
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: Text(
              //     'No attendances found',
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(3.0),
                width: double.infinity,
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
                        'Sun, 11 Feb 2024',
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
                                Icons.access_time,
                                size: 30,
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clock In',
                                  ),
                                  Text(
                                    '9:00 AM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 30,
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clock Out',
                                  ),
                                  Text(
                                    '5:00 PM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: fab(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Attendances',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.primaryColor,
              CustomColors.secondaryColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      foregroundColor: Colors.white,
    );
  }

  FloatingActionButton fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/clock');
      },
      backgroundColor: Colors.white,
      tooltip: 'Clock In/Out',
      shape: CircleBorder(
        side: BorderSide(
          color: CustomColors.tertiaryColor,
          width: 0.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              CustomColors.primaryColor,
              CustomColors.secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          Icons.access_time_sharp,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}