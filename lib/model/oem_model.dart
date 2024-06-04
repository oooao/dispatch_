import 'dart:convert';

class OEMModel {
  String oem_id;
  String user_id;
  List<dynamic> services;
  String city;
  String area;
  String address;
  String date;
  String situation;
  String key_info;
  String password;
  String notice;
  String worker_id;
  String parking;
  String parking_no;
  String signature;
  String worker;
  String date_added;
  String pdf;
  int total;
  List<dynamic> photos;
  String status;

  OEMModel({
    this.oem_id = "",
    this.user_id = "",
    required this.services,
    this.city = "",
    this.area = "",
    this.address = "",
    this.date = "",
    this.situation = "",
    this.key_info = "",
    this.password = "",
    this.notice = "",
    this.worker_id = "",
    this.parking = "",
    this.parking_no = "",
    this.signature = "",
    this.worker = "",
    this.date_added = "",
    this.total = 0,
    required this.photos,
    this.status = "",
    this.pdf = "",
  });

  factory OEMModel.fromMap(Map data) {
    return OEMModel(
      oem_id: data['oem_id'] ?? "",
      user_id: data['user_id'] ?? "",
      services: json.decode(data['services']) ?? [],
      city: data['city'] ?? "",
      area: data['area'] ?? "",
      address: data['address'] ?? "",
      date: data['date'] ?? "",
      situation: data['situation'] ?? "",
      key_info: data['key_info'] ?? "",
      password: data['password'] ?? "",
      notice: data['notice'] ?? "",
      parking: data['parking'] ?? "",
      parking_no: data['parking_no'] ?? "",
      signature: data['signature'] ?? "",
      worker: data['worker'] ?? "",
      worker_id: data['worker_id'] ?? "",
      date_added: data['date_added'] ?? "",
      total: int.tryParse(data['total'] ?? "0") ?? 0,
      photos: json.decode(data['photo']) ?? [],
      status: data['status'] ?? "",
      pdf: data['pdf'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "oem_id": oem_id,
      "user_id": user_id,
      "services": services,
      "city": city,
      "area": area,
      "address": address,
      "date": date,
      "situation": situation,
      "key_info": key_info,
      "password": password,
      "notice": notice,
      "parking": parking,
      "parking_no": parking_no,
      "signature": signature,
      "worker": worker,
      "worker_id": worker_id,
      "date_added": date_added,
      "total": total,
      "photo": json.encode(photos),
      "status": status,
      "pdf": pdf,
    };
  }
}
