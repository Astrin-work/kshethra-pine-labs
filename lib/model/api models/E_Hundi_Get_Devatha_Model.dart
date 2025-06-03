// To parse this JSON data, do
//
//     final ehundigetdevathamodel = ehundigetdevathamodelFromJson(jsonString);

import 'dart:convert';

List<Ehundigetdevathamodel> ehundigetdevathamodelFromJson(String str) => List<Ehundigetdevathamodel>.from(json.decode(str).map((x) => Ehundigetdevathamodel.fromJson(x)));

String ehundigetdevathamodelToJson(List<Ehundigetdevathamodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ehundigetdevathamodel {
  int devathaId;
  String devathaName;
  String devathaImage;
  bool status;

  Ehundigetdevathamodel({
    required this.devathaId,
    required this.devathaName,
    required this.devathaImage,
    required this.status,
  });

  factory Ehundigetdevathamodel.fromJson(Map<String, dynamic> json) => Ehundigetdevathamodel(
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
