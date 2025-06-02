// To parse this JSON data, do
//
//     final postvazhipadumodel = postvazhipadumodelFromJson(jsonString);

import 'dart:convert';

List<Postvazhipadumodel> postvazhipadumodelFromJson(String str) => List<Postvazhipadumodel>.from(json.decode(str).map((x) => Postvazhipadumodel.fromJson(x)));

String postvazhipadumodelToJson(List<Postvazhipadumodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postvazhipadumodel {
  int serialNumber;
  List<Receipt> receipts;

  Postvazhipadumodel({
    required this.serialNumber,
    required this.receipts,
  });

  factory Postvazhipadumodel.fromJson(Map<String, dynamic> json) => Postvazhipadumodel(
    serialNumber: json["serialNumber"],
    receipts: List<Receipt>.from(json["receipts"].map((x) => Receipt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serialNumber": serialNumber,
    "receipts": List<dynamic>.from(receipts.map((x) => x.toJson())),
  };
}

class Receipt {
  String personName;
  String personStar;
  int quantity;
  int rate;
  String offerName;
  DateTime offerDate;
  DateTime receiptDate;
  String type;

  Receipt({
    required this.personName,
    required this.personStar,
    required this.quantity,
    required this.rate,
    required this.offerName,
    required this.offerDate,
    required this.receiptDate,
    required this.type,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    personName: json["personName"],
    personStar: json["personStar"],
    quantity: json["quantity"],
    rate: json["rate"],
    offerName: json["offerName"],
    offerDate: DateTime.parse(json["offerDate"]),
    receiptDate: DateTime.parse(json["receiptDate"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "personName": personName,
    "personStar": personStar,
    "quantity": quantity,
    "rate": rate,
    "offerName": offerName,
    "offerDate": "${offerDate.year.toString().padLeft(4, '0')}-${offerDate.month.toString().padLeft(2, '0')}-${offerDate.day.toString().padLeft(2, '0')}",
    "receiptDate": "${receiptDate.year.toString().padLeft(4, '0')}-${receiptDate.month.toString().padLeft(2, '0')}-${receiptDate.day.toString().padLeft(2, '0')}",
    "type": type,
  };
}
