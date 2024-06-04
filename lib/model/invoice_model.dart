import 'dart:convert';

class InvoiceModel {
  String oem_id;
  List<dynamic> item_and_description;

  InvoiceModel({this.oem_id = "", required this.item_and_description});

  factory InvoiceModel.fromMap(Map data) {
    return InvoiceModel(
      oem_id: data['oem_id'] ?? "",
      item_and_description: json.decode(data['item_and_descripiton']) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "oem_id": oem_id,
      "item_and_description": json.encode(item_and_description),
    };
  }
}
