class AttendanceListModel {
  String? status;
  List<Data>? data;

  AttendanceListModel({this.status, this.data});

  AttendanceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  DateTime? clockIn;
  DateTime? clockOut;
  String? latitudeIn;
  String? longitudeIn;
  String? latitudeOut;
  String? longitudeOut;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.clockIn,
      this.clockOut,
      this.latitudeIn,
      this.longitudeIn,
      this.latitudeOut,
      this.longitudeOut,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clockIn =
        json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null;
    clockOut =
        json['clock_out'] != null ? DateTime.parse(json['clock_out']) : null;
    latitudeIn = json['latitude_in'];
    longitudeIn = json['longitude_in'];
    latitudeOut = json['latitude_out'];
    longitudeOut = json['longitude_out'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['clock_in'] = this.clockIn;
    data['clock_out'] = this.clockOut;
    data['latitude_in'] = this.latitudeIn;
    data['longitude_in'] = this.longitudeIn;
    data['latitude_out'] = this.latitudeOut;
    data['longitude_out'] = this.longitudeOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
