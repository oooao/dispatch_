import 'dart:convert';

class ODMModel {
  String odm_id;
  String name;
  String address;
  String phone;
  String date;
  List<String> photos;
  String note;
  int type; // 0: 系統櫃，1: 木地板SPC，2: 超耐磨木地板
  String signature;
  String status;

  ODMModel({
    this.odm_id = "",
    this.name = "",
    this.address = "",
    this.phone = "",
    this.date = "",
    required this.photos,
    this.note = "",
    this.type = 0,
    this.signature = "",
    this.status = "",
  });

  factory ODMModel.fromMap(Map data) {
    return ODMModel(
      odm_id: data['odm_id'] ?? "",
      name: data['name'] ?? "",
      address: data['address'] ?? "",
      phone: data['phone'] ?? "",
      date: data['date'] ?? "",
      photos: json.decode(data['photo']) ?? [],
      note: data['note'] ?? "",
      type: data['type'] ?? "",
      signature: data['signature'] ?? "",
      status: data['status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "odm_id": odm_id,
      "name": name,
      "address": address,
      "phone": phone,
      "date": date,
      "photo": json.encode(photos),
      "note": note,
      "type": type,
      "signature": signature,
      "status": status,
    };
  }

  String getTypeString() {
    switch (type) {
      case 0:
        return "系統櫃";
      case 1:
        return "木地板SPC";
      case 2:
        return "超耐磨木地板";
    }
    return "";
  }
}
