class ServerTimeModel {
  String? status;
  Data? data;

  ServerTimeModel({this.status, this.data});

  ServerTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  DateTime? date;
  int? timezoneType;
  String? timezone;

  Data({this.date, this.timezoneType, this.timezone});

  Data.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
