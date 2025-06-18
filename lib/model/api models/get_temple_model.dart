// To parse this JSON data, do
//
//     final getTemplemodel = getTemplemodelFromJson(jsonString);

import 'dart:convert';

GetTemplemodel getTemplemodelFromJson(String str) => GetTemplemodel.fromJson(json.decode(str));

String getTemplemodelToJson(GetTemplemodel data) => json.encode(data.toJson());

class GetTemplemodel {
  int templeId;
  String templeName;
  String phoneNumber;
  String address;
  bool status;

  GetTemplemodel({
    required this.templeId,
    required this.templeName,
    required this.phoneNumber,
    required this.address,
    required this.status,
  });

  factory GetTemplemodel.fromJson(Map<String, dynamic> json) => GetTemplemodel(
    templeId: json["templeId"],
    templeName: json["templeName"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "templeId": templeId,
    "templeName": templeName,
    "phoneNumber": phoneNumber,
    "address": address,
    "status": status,
  };
}
