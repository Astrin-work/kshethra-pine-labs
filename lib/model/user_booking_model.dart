  import 'package:easy_localization/easy_localization.dart';

  class UserBookingModel {
    String? name = "";
    String? star = "".tr();
    String? date = "";
    String? phno;
    String? option;
    String? repMethode;
    String? day;
    List<Map<String, dynamic>> vazhiPad = [];

    UserBookingModel({
       this.name,
      this.star,
      required this.vazhiPad,
      this.phno,
      this.date,
      this.option,
      this.repMethode,
      this.day,
    });
  }
