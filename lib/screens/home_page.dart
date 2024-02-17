import 'package:attendance_app/models/server_time_model.dart';
import 'package:attendance_app/providers/attendances_list_provider.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/providers/server_time_provider.dart';
import 'package:attendance_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void getServerTime(BuildContext context) {
    Provider.of<ServerTimeProvider>(context, listen: false).getServerTime();
  }

  void getAttendancesList(BuildContext context) {
    Provider.of<AttendanceListProvider>(context, listen: false)
        .getAttendances(context);
  }

  void _logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false)
        .logout(context)
        .then((value) => {Navigator.pushReplacementNamed(context, '/login')});
  }

  @override
  Widget build(BuildContext context) {
    getServerTime(context);
    getAttendancesList(context);
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Welcome back, ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  Consumer(
                      builder: (context, AuthProvider authProvider, child) {
                    if (authProvider.user != null) {
                      return ShaderMask(
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
                          '${authProvider.user!.name!} !',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
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
                child: Consumer(
                  builder: (context, ServerTimeProvider serverTime, child) {
                    if (serverTime.serverTime != null) {
                      ServerTimeModel data = serverTime.serverTime!;
                      return Column(
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
                                    data.data!.timezone!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Provider.of<ServerTimeProvider>(
                                        context,
                                        listen: false,
                                      ).refreshServerTime();
                                    },
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
                                  DateFormat("EEE, d MMM yyyy")
                                      .format(data.data!.date!),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  DateFormat("h:mm a").format(data.data!.date!),
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
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Here are your latest attendances',
              ),
              SizedBox(height: 20.0),
              Consumer(
                builder: (context, AttendanceListProvider attendances, child) {
                  if (attendances.attendances != null) {
                    if (attendances.attendances!.data!.isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.0);
                        },
                        itemCount: attendances.attendances!.data!.length,
                        itemBuilder: (context, index) {
                          final sortedData = attendances.attendances!.data!
                            ..sort(
                                (a, b) => b.createdAt!.compareTo(a.createdAt!));
                          final attendance = sortedData[index];
                          return recordData(
                            attendance.createdAt!,
                            attendance.clockIn,
                            attendance.clockOut,
                          );
                        },
                      );
                    } else {
                      return notFoundData();
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.secondaryColor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: fab(context),
    );
  }

  Container notFoundData() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.tertiaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'No attendances found',
      ),
    );
  }

  Container recordData(
      DateTime createdAt, DateTime? clock_in, DateTime? clock_out) {
    return Container(
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
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: CustomColors.tertiaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(
              DateFormat("EEE, d MMM yyyy").format(createdAt),
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
                          DateFormat("h:mm a").format(clock_in!),
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
                          clock_out != null
                              ? DateFormat("h:mm a").format(clock_out)
                              : '--',
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
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () async {
          await Provider.of<AttendanceListProvider>(context, listen: false)
              .refreshAttendancesList(context);
        },
        icon: Icon(Icons.refresh_sharp),
      ),
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
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ),
      ],
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
