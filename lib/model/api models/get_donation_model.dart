// To parse this JSON data, do
//
//     final getdonationmodel = getdonationmodelFromJson(jsonString);

import 'dart:convert';

List<Getdonationmodel> getdonationmodelFromJson(String str) => List<Getdonationmodel>.from(json.decode(str).map((x) => Getdonationmodel.fromJson(x)));

String getdonationmodelToJson(List<Getdonationmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getdonationmodel {
  int acctHeadId;
  String acctHeadName;
  DateTime entryTime;
  bool status;

  Getdonationmodel({
    required this.acctHeadId,
    required this.acctHeadName,
    required this.entryTime,
    required this.status,
  });

  factory Getdonationmodel.fromJson(Map<String, dynamic> json) => Getdonationmodel(
    acctHeadId: json["acctHeadId"],
    acctHeadName: json["acctHeadName"],
    entryTime: DateTime.parse(json["entryTime"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "acctHeadId": acctHeadId,
    "acctHeadName": acctHeadName,
    "entryTime": entryTime.toIso8601String(),
    "status": status,
  };
}
