class UserBookingModel {
  String name = "";
  String? star = "";
  String? date = "";
  String? phno;
  String? option;
  String? repMethode;
  String? day;
  List<Map<String, dynamic>> vazhiPad = [];

  UserBookingModel({
    required this.name,
    this.star,
    required this.vazhiPad,
    this.phno,
    this.date,
    this.option,
    this.repMethode,
    this.day,
  });
}
