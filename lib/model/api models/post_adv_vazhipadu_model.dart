// To parse this JSON data, do
//
//     final postAdvVazhipaduModel = postAdvVazhipaduModelFromJson(jsonString);

import 'dart:convert';

PostAdvVazhipaduModel postAdvVazhipaduModelFromJson(String str) => PostAdvVazhipaduModel.fromJson(json.decode(str));

String postAdvVazhipaduModelToJson(PostAdvVazhipaduModel data) => json.encode(data.toJson());

class PostAdvVazhipaduModel {
  bool success;
  List<SuccessList> successList;

  PostAdvVazhipaduModel({
    required this.success,
    required this.successList,
  });

  factory PostAdvVazhipaduModel.fromJson(Map<String, dynamic> json) => PostAdvVazhipaduModel(
    success: json["success"],
    successList: List<SuccessList>.from(json["successList"].map((x) => SuccessList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "successList": List<dynamic>.from(successList.map((x) => x.toJson())),
  };
}

class SuccessList {
  String offerName;
  String personName;
  String personStar;
  String phoneNumber;
  String address;
  int rate;
  int quantity;
  int totalAmount;
  List<DateTime> bookingDates;
  int postalCharge;
  String postalType;

  SuccessList({
    required this.offerName,
    required this.personName,
    required this.personStar,
    required this.phoneNumber,
    required this.address,
    required this.rate,
    required this.quantity,
    required this.totalAmount,
    required this.bookingDates,
    required this.postalCharge,
    required this.postalType,
  });

  factory SuccessList.fromJson(Map<String, dynamic> json) => SuccessList(
    offerName: json["offerName"],
    personName: json["personName"],
    personStar: json["personStar"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    rate: json["rate"],
    quantity: json["quantity"],
    totalAmount: json["totalAmount"],
    bookingDates: List<DateTime>.from(json["bookingDates"].map((x) => DateTime.parse(x))),
    postalCharge: json["postalCharge"],
    postalType: json["postalType"],
  );

  Map<String, dynamic> toJson() => {
    "offerName": offerName,
    "personName": personName,
    "personStar": personStar,
    "phoneNumber": phoneNumber,
    "address": address,
    "rate": rate,
    "quantity": quantity,
    "totalAmount": totalAmount,
    "bookingDates": List<dynamic>.from(bookingDates.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "postalCharge": postalCharge,
    "postalType": postalType,
  };
}
