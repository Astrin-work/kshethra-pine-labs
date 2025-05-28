// To parse this JSON data, do
//
//     final godmodel = godmodelFromJson(jsonString);

import 'dart:convert';

List<Godmodel> godmodelFromJson(String str) => List<Godmodel>.from(json.decode(str).map((x) => Godmodel.fromJson(x)));

String godmodelToJson(List<Godmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Godmodel {
  int devathaId;
  String devathaName;
  String devathaImage;
  bool status;

  Godmodel({
    required this.devathaId,
    required this.devathaName,
    required this.devathaImage,
    required this.status,
  });

  factory Godmodel.fromJson(Map<String, dynamic> json) => Godmodel(
    devathaId: json["devathaId"],
    devathaName: json["devathaName"],
    devathaImage: json["devathaImage"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "devathaId": devathaId,
    "devathaName": devathaName,
    "devathaImage": devathaImage,
    "status": status,
  };
}
