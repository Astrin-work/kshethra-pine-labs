// To parse this JSON data, do
//
//     final vazhipadumodel = vazhipadumodelFromJson(jsonString);

import 'dart:convert';

List<Vazhipadumodel> vazhipadumodelFromJson(String str) => List<Vazhipadumodel>.from(json.decode(str).map((x) => Vazhipadumodel.fromJson(x)));

String vazhipadumodelToJson(List<Vazhipadumodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vazhipadumodel {
  int offerId;
  int devathaId;
  int counterId;
  String offerName;
  int cost;
  int limit;
  DateTime enteryTime;
  bool status;
  dynamic devatha;
  dynamic offeringCounter;

  Vazhipadumodel({
    required this.offerId,
    required this.devathaId,
    required this.counterId,
    required this.offerName,
    required this.cost,
    required this.limit,
    required this.enteryTime,
    required this.status,
    required this.devatha,
    required this.offeringCounter,
  });

  factory Vazhipadumodel.fromJson(Map<String, dynamic> json) => Vazhipadumodel(
    offerId: json["offerId"],
    devathaId: json["devathaId"],
    counterId: json["counterId"],
    offerName: json["offerName"],
    cost: json["cost"],
    limit: json["limit"],
    enteryTime: DateTime.parse(json["enteryTime"]),
    status: json["status"],
    devatha: json["devatha"],
    offeringCounter: json["offeringCounter"],
  );

  Map<String, dynamic> toJson() => {
    "offerId": offerId,
    "devathaId": devathaId,
    "counterId": counterId,
    "offerName": offerName,
    "cost": cost,
    "limit": limit,
    "enteryTime": enteryTime.toIso8601String(),
    "status": status,
    "devatha": devatha,
    "offeringCounter": offeringCounter,
  };
}
